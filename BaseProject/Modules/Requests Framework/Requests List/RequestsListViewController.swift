//
//  RequestsListViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/19/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class RequestsListViewController: UIViewController {

    // MARK: - IBOutlets -
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Stored Properties -
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: RequestsFrameworkCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: RequestsFrameworkCollectionViewCell.reuseIdentifier)
        collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }

}


// MARK: - UICollectionViewDataSource & UICollectionViewDelegate -
// ----------------------------------------------------------------------------

extension RequestsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PaymentRouter.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RequestsFrameworkCollectionViewCell.reuseIdentifier, for: indexPath) as! RequestsFrameworkCollectionViewCell
        cell.requestCase = PaymentRouter.allCases[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    // Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cellSelected = collectionView.cellForItem(at: indexPath) as? RequestsFrameworkCollectionViewCell else {return}
        coordinator?.showRequestDetail(with: cellSelected.requestCase)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    // DelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200.0)
    }
}
