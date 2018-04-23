//
//  CoverCollectionViewFlowLayout.swift
//  CoverCollection
//
//  Created by Tomasz Bogusz on 22.04.2018.
//  Copyright © 2018 Tomasz Bogusz. All rights reserved.
//

import UIKit

class CoverCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override var collectionViewContentSize: CGSize {
        get {
            // Since we know that there will be only one section, we hardcode 0 as section index (for workshop purpose)
            var width: CGFloat = 0
            var height: CGFloat = 0
            if let numberOfItems = collectionView?.numberOfItems(inSection: 0) {
                width = itemSize.width * CGFloat(numberOfItems + 2) + CoverConstants.elementPadding * CGFloat(numberOfItems + 1)
            }
            if let superview = collectionView?.superview {
                height = superview.bounds.height - superview.safeAreaInsets.top
            }
            return CGSize(width: width, height: height)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var coverAttributesArray = [CoverCollectionViewLayoutAttributes]()
        if let attributesArray = super.layoutAttributesForElements(in: rect) {
            for attributes in attributesArray {
                if let collectionView = collectionView {
                    // Modify each item's frame based on it's distance from contentOffset
                    let offsetDiff = CGFloat(attributes.indexPath.item) * (itemSize.width + CoverConstants.elementPadding) - collectionView.contentOffset.x
                    let insetValue = min(abs(offsetDiff) * CoverConstants.offsetDiffScaleMulitplier, itemSize.width * CoverConstants.cellMaxScaleMultiplier)
                    let offsetValue = offsetDiff < 0 ? max(offsetDiff * CoverConstants.offsetDiffScaleMulitplier, -itemSize.width * CoverConstants.cellMaxScaleMultiplier) : min(offsetDiff * CoverConstants.offsetDiffScaleMulitplier, itemSize.width * CoverConstants.cellMaxScaleMultiplier)
                    
                    var frame = attributes.frame
                    frame = frame.insetBy(dx: insetValue, dy: insetValue)
                    frame = frame.offsetBy(dx: offsetValue, dy: 0)
                    
                    if let coverAttributes = layoutAttributesForItem(at: attributes.indexPath) as? CoverCollectionViewLayoutAttributes {
                        coverAttributes.frame = frame
                        coverAttributesArray.append(coverAttributes)
                    }
                }
            }
            
            return coverAttributesArray
        }
        return nil
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = CoverCollectionViewLayoutAttributes(forCellWith: indexPath)
        // Change background color
        if let collectionView = collectionView {
            let offsetDiff = CGFloat(indexPath.item) * (itemSize.width + CoverConstants.elementPadding) - collectionView.contentOffset.x
            attributes.backgroundColor = mixGreenAndRedThroughYellow(greenAmount: min(1.0, abs(offsetDiff) / (itemSize.width + CoverConstants.elementPadding)))
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // MARK: - Helper functions
    func mixGreenAndRedThroughYellow(greenAmount: CGFloat) -> UIColor {
        return greenAmount < 0.5 ? UIColor(red: (1.0), green: greenAmount * 2, blue: 0.0, alpha: 1.0) : UIColor(red: (1.0 - greenAmount * 2), green: 1.0, blue: 0.0, alpha: 1.0)
    }
}
