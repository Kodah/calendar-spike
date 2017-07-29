//
//  AccessibiltySettings.swift
//  Sky
//
//  Created by Prescott, Ste on 20/02/2017.
//  Copyright © 2017 Sky UK Limited. All rights reserved.
//

extension Accessibility {
    
    public enum Settings {
        case reduceMotion
        case reduceTransparancy
        case closedCaptioning
        
        public var isEnabled: Bool {
            switch self {
            case .reduceMotion:
                return UIAccessibilityIsReduceMotionEnabled()
            case .reduceTransparancy:
                return UIAccessibilityIsReduceTransparencyEnabled()
            case .closedCaptioning:
                return UIAccessibilityIsClosedCaptioningEnabled()
            }
        }
        
        fileprivate static var all: [Settings] {
            return [ .reduceMotion, reduceTransparancy, .closedCaptioning ]
        }
        
        fileprivate var name: NSNotification.Name {
            switch self {
            case .reduceMotion:
                return .UIAccessibilityReduceMotionStatusDidChange
            case .reduceTransparancy:
                return .UIAccessibilityReduceTransparencyStatusDidChange
            case .closedCaptioning:
                return .UIAccessibilityClosedCaptioningStatusDidChange
            }
        }
    }
}

extension Accessibility.Settings {
    fileprivate static func setting(for name: Notification.Name) -> Accessibility.Settings? {
        return Accessibility.Settings.all.first { notification in return notification.name == name }
    }
}

// MARK:- Settings observer

extension Accessibility.Settings {
    
    fileprivate class Observer {
        
        static let singleton = Observer()
        
        init(){ }
        
        fileprivate static func startObserving(_ setting: Accessibility.Settings) {
            NotificationCenter.default.addObserver(singleton,
                                                   selector: #selector(settingStatusDidChange(_:)),
                                                   name: setting.name,
                                                   object: nil)
        }
        
        fileprivate static func stopObserving(_ setting: Accessibility.Settings) {
            NotificationCenter.default.removeObserver(singleton,
                                                      name: setting.name,
                                                      object: nil)
        }
        
        @objc fileprivate func settingStatusDidChange(_ notification: NSNotification) {
            guard let setting = Accessibility.Settings.setting(for: notification.name)
                else { return }
            
            Accessibility.Settings.subscribers[setting.name]?.forEach { $0.reportChange(setting) }
        }
    }
}

// MARK:- Settings subscriber

extension Accessibility.Settings {
    
    fileprivate class Subscriber: AnyObject, CustomStringConvertible, Hashable {
        
        weak var subscriber: AnyObject?
        let id: ObjectIdentifier
        let description: String
        let reportChange: (Accessibility.Settings) -> ()
        
        var hashValue: Int {
            return description.hashValue
        }
        
        init<Target: AnyObject>(target: Target,
             action: @escaping (Target) -> (Accessibility.Settings) -> ()) {
            
            subscriber = target
            id = ObjectIdentifier(target)
            description = "Subscribtion → \(target)"
            
            reportChange = { [weak target] setting in
                guard let target = target else { return }
                action(target)(setting)
            }
        }
        
        public static func == (lhs: Subscriber, rhs: Subscriber) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

// MARK:- Settings subscribing & unsubscribing

extension Accessibility.Settings {
    
    fileprivate static var subscribers: [Notification.Name : Set<Accessibility.Settings.Subscriber>] = [:]
    
    public func subscribe <Target: AnyObject> (
        _ target: Target,
        fromNext: Bool = false,
        action: @escaping (Target) -> (Accessibility.Settings) -> ()) {
        
        if Accessibility.Settings.subscribers[self.name] == nil {
            Observer.startObserving(self)
        }
        
        Accessibility.Settings.subscribers[self.name, else: []].insert(Subscriber(target: target, action: action))
        
        if !fromNext {
            action(target)(self)
        }
    }
    
    public func unsubscribe<Target: AnyObject>(_ target: Target) {
        guard let index = Accessibility.Settings.subscribers[self.name]?.index(where: { $0.subscriber === target })
            else { return }
        
        Accessibility.Settings.subscribers[self.name]?.remove(at: index)
        
        guard let subscribersForSetting = Accessibility.Settings.subscribers[self.name], subscribersForSetting.isEmpty
            else { return }
        
        Accessibility.Settings.subscribers[self.name] = nil
        Accessibility.Settings.Observer.stopObserving(self)
    }
}
