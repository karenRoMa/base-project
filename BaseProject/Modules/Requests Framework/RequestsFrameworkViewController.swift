//
//  RequestsFrameworkViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/11/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class RequestsFrameworkViewController: UIViewController {
    
    // MARK: - Singleton Properties -
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var featureView: UIView!
    
    // MARK: - Stored Properties -
    
    /// MainCoordinator
    var coordinator : MainCoordinator?
    

    // MARK: - View Delegate Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureView()
    }
    
    // MARK: - View configuration -
    
    func configureView() {
        // Here we can do all related to view style or view configuration
//        addDismissKeyboardWhenTappedAround()
        setFeatureView()
        scrollView.isExclusiveTouch = false
        scrollView.delaysContentTouches = false
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: PaymentFeatureCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: PaymentFeatureCollectionViewCell.reuseIdentifier)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }

    // MARK: - Class Methods -
    
    func setFeatureView(with feature: PaymentFeature = .registerCard) {

        for controller in self.children {
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
        
        var controller: UIViewController = feature.controller
        
        if let requestsController = controller as? RequestsListViewController {
            requestsController.coordinator = self.coordinator
            controller = requestsController
        }
        //add as a childviewcontroller
        addChild(controller)
        controller.view.bounds = featureView.frame
        // Add the child's View as a subview
        scrollView.addSubview(controller.view)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // tell the childviewcontroller it's contained in it's parent
        controller.didMove(toParent: self)
        
        scrollView.setContentOffset(CGPoint.zero, animated: false)
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate -
// ----------------------------------------------------------------------------

extension RequestsFrameworkViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PaymentFeature.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentFeatureCollectionViewCell.reuseIdentifier, for: indexPath) as! PaymentFeatureCollectionViewCell
        cell.feature = PaymentFeature.allCases[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellSelected = collectionView.cellForItem(at: indexPath) as? PaymentFeatureCollectionViewCell else {return}
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setFeatureView(with: cellSelected.feature)
    }
    
    // DelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200.0, height: 50)
    }
}
