//
//  ViewController.swift
//  CoverCollection
//
//  Created by Tomasz Bogusz on 21.04.2018.
//  Copyright © 2018 Tomasz Bogusz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Model
    
    let model = Array(1...100)
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.setCollectionViewLayout(CoverCollectionViewFlowLayout(), animated: false)
            collectionViewLayout.scrollDirection = .horizontal
        }
    }
    
    // MARK: - Private properties
    
    private var collectionViewLayout: CoverCollectionViewFlowLayout! { return collectionView?.collectionViewLayout as? CoverCollectionViewFlowLayout}

    // MARK: - View Controller's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recomputeLayout(viewSize: collectionView.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        recomputeLayout(viewSize: size)
        adjustContentOffset(for: size)
    }
    
    private func recomputeLayout(viewSize: CGSize) {
        let itemSize = (viewSize.width - (CGFloat(CoverConstants.elementsPerRow - 1) * CoverConstants.elementPadding)) / CGFloat(CoverConstants.elementsPerRow)
        let margin = (viewSize.height - itemSize) / 2
        collectionViewLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: margin, left: itemSize + CoverConstants.elementPadding, bottom: margin, right: itemSize + CoverConstants.elementPadding)
        collectionViewLayout.minimumLineSpacing = CoverConstants.elementPadding
        collectionViewLayout.invalidateLayout()
    }
    
    private func adjustContentOffset(for size: CGSize) {
        // TODO
        collectionView.contentOffset.x *= size.width / collectionView.bounds.width
        collectionViewLayout.invalidateLayout()
    }
    
    

}

// MARK: - UICollectionViewDelegate implementation

extension ViewController: UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Desired targetContentOffset.pointee.x equals [n * (itemWidth + elementPadding)], where n is the index of item on the left
        let n = (targetContentOffset.pointee.x / (collectionViewLayout.itemSize.width + CoverConstants.elementPadding)).rounded()
        let x = n * (collectionViewLayout.itemSize.width + CoverConstants.elementPadding)
        targetContentOffset.pointee.x = x
    }
    
}

// MARK: - UICollectionViewDataSource implementation

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cover Cell", for: indexPath)
        if let coverCell = cell as? CoverCollectionViewCell {
            coverCell.label.text = String(model[indexPath.item])
        }
        
        return cell
    }
    
}

