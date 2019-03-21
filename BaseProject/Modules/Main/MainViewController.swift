//
//  MainViewController.swift
//  Payments
//
//  Created by Karen Rodriguez on 3/6/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

// MARK: - MainViewController -
// This is a example of how the a View Controller should be configured

class MainViewController: UIViewController {

    // MARK: - Singleton properties -
    
    static let singletonExample: String = "Singleton Example"
    
    // MARK: - IBOutlets -
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Stored Properties -
    
    /// MainCoordinator
    var coordinator : MainCoordinator?
    
    /// ViewModel
    lazy var viewModel : ViewModel? = {
        return ViewModel()
    }()
    
    // MARK: - View Delegate Methods -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        initViewModel()
        configureView()
    }
    
    // MARK: - View configuration -

    func configureView() {
        // Here we can do all related to view style or view configuration
        titleLabel.textColor = UIColor.darkSkyBlue()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = MainTableViewCell.rowHeight
        tableView.register(UINib(nibName: MainTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
    }

    // MARK: - View Model Initial Configuration -
    
    func initViewModel() {
        /// Assign delegate implemented in [this section](x-source-tag://ViewModel)
        viewModel?.delegate = self
        
        viewModel?.fetchFramework()
    }
    
    // MARK: - IBActions -
    
    /*
     Insert here all the ibactions needed in the view
     */
    

    // MARK: - Class Methods -
    
    /*
     Insert here misc methods used in the view controller class
     */
}

// MARK: - UITableViewDataSouce & UITableViewDelegate -
// ----------------------------------------------------------------------------

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Data Source -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.frameworks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as! MainTableViewCell
        cell.framework = viewModel?.frameworks[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    // MARK: - Delegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let frameworkSelected = viewModel?.frameworks[indexPath.row] {
            coordinator?.goToFrameworkDetail(with: frameworkSelected)
        }
    }
    
}

// MARK: - View Model Delegate -
// - Tag: ViewModel
// ----------------------------------------------------------

extension MainViewController : ViewModelDelegate {
    
    func reloadUI() {
        tableView.reloadData()
    }
    
    func delegateMethodExample() {
        print("This is a example of a delegate Method")
    }
}

