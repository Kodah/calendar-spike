//
//  NSIndexPath.swift
//  EnamelKit
//
//  Created by Prescott, Ste on 30/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//


public enum IndexPathPosition: Int {
    case first
    case inner
    case last
    case independent
    case none
}

public extension IndexPathPosition {
    
    public var outerEdges: Edges {
        switch self
        {
        case .first: return [.left, .top, .right]
        case .inner: return [.left, .right]
        case .last: return [.left, .bottom, .right]
        case .independent: return [.all]
        case .none: return []
        }
    }
}

extension IndexPath {
    
    public func position(in vc: UICollectionView) -> IndexPathPosition {
        guard vc.numberOfItems(inSection: section) > 0
            else { return .none }
        
        switch (isFirstRowForSection(in: vc), isLastRowForSection(in: vc))
        {
        case (true, false): return .first
        case (false, false): return .inner
        case (false, true): return .last
        case (true, true): return .independent
        }
    }
}

extension IndexPath {
    
    public var nextRow: IndexPath {
        return IndexPath(row: row + 1, section: section)
    }
    
    public var previousRow: IndexPath {
        return IndexPath(row: row - 1, section: section)
    }
    
    public var nextSection: IndexPath {
        return IndexPath(row: row, section: section + 1)
    }
    
    public var previousSection: IndexPath {
        return IndexPath(row: row, section: section - 1)
    }
    
    public func isFirstSection(in collectionView: UICollectionView) -> Bool {
        return section == 0 && collectionView.numberOfSections > 0
    }
    
    public func isLastSection(in collectionView: UICollectionView) -> Bool {
        return section == collectionView.numberOfSections - 1
    }
    
    public func isFirstRowForSection(in collectionView: UICollectionView) -> Bool {
        return row == 0 && collectionView.numberOfItems(inSection: section) > 0
    }
    
    public func isLastRowForSection(in collectionView: UICollectionView) -> Bool {
        return collectionView.numberOfItems(inSection: section) == row + 1
    }
}

extension Int {
    
    public func isFirstSection(in collectionView: UICollectionView) -> Bool {
        return collectionView.numberOfSections > 0 && self == 0
    }
    
    public func isLastSection(in collectionView: UICollectionView) -> Bool {
        return self == collectionView.numberOfSections - 1
    }
}
