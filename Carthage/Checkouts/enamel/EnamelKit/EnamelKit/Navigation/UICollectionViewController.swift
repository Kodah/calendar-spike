//
//  UICollectionView.swift
//  EnamelKit
//
//  Created by Rankovic, Milos (Developer) on 08/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

extension UICollectionViewController {
    
    public func position(of indexPath: IndexPath) -> IndexPathPosition {
        guard let cv = collectionView else { return .none }
        return indexPath.position(in: cv)
    }
    
    // MARK:- First
    
    public func isFirst(section: Int) -> Bool {
        guard let cv = collectionView else { return false }
        return section.isFirstSection(in: cv)
    }
    
    @objc(isFirstSection:)
    public func isFirst(section indexPath: IndexPath) -> Bool {
        guard let cv = collectionView else { return false }
        return indexPath.isFirstSection(in: cv)
    }
    
    public func isFirst(row indexPath: IndexPath) -> Bool {
        guard let cv = collectionView else { return false }
        return indexPath.isFirstRowForSection(in: cv)
    }
    
    // MARK:- Last
    
    public func isLast(section: Int) -> Bool {
        guard let cv = collectionView else { return false }
        return section.isLastSection(in: cv)
    }
    
    @objc(isLastSection:)
    public func isLast(section indexPath: IndexPath) -> Bool {
        guard let cv = collectionView else { return false }
        return indexPath.isLastSection(in: cv)
    }
    
    public func isLast(row indexPath: IndexPath) -> Bool {
        guard let cv = collectionView else { return false }
        return indexPath.isLastRowForSection(in: cv)
    }
}
