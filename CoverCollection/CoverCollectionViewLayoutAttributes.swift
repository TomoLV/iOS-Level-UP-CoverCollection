//
//  CoverCollectionViewLayoutAttributes.swift
//  CoverCollection
//
//  Created by Tomasz Bogusz on 23.04.2018.
//  Copyright © 2018 Tomasz Bogusz. All rights reserved.
//

import UIKit

class CoverCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var backgroundColor: UIColor = .green
    
    override init() {
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? CoverCollectionViewLayoutAttributes {
            if backgroundColor != rhs.backgroundColor {
                return false
            }
            return super.isEqual(object)
        } else {
            return false
        }
    }
    
    override func copy() -> Any {
        let copy = super.copy() as? CoverCollectionViewLayoutAttributes
        copy?.backgroundColor = self.backgroundColor
        return copy
    }
}
