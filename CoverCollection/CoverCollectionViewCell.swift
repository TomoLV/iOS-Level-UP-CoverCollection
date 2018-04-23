//
//  CoverCollectionViewCell.swift
//  CoverCollection
//
//  Created by Tomasz Bogusz on 21.04.2018.
//  Copyright © 2018 Tomasz Bogusz. All rights reserved.
//

import UIKit

class CoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let coverAttributes = layoutAttributes as? CoverCollectionViewLayoutAttributes {
            backgroundColor = coverAttributes.backgroundColor
        }
    }
}
