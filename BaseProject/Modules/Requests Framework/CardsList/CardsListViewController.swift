//
//  CardsListViewController.swift
//  BaseProject
//
//  Created by Karen Rodriguez on 3/15/19.
//  Copyright © 2019 Karen Rodriguez. All rights reserved.
//

import UIKit

class CardsListViewController: UIViewController {

    // MARK: - Outlets -
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Stored Properties -
    
    var emptyDataLabel: UILabel!
    
    /// Refresh Control
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.palidPink()
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        reloadTableView()
    }
 
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.insertSubview(refreshControl, at: 0)
        tableView.rowHeight = CardTableViewCell.rowHeight
        tableView.register(UINib(nibName: CardTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CardTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Class Methods -
    
    /// Refresh control handler
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        reloadTableView()
        refreshControl.endRefreshing()
    }
    
    func reloadTableView() {
        manageEmptyLabel(hidden: ProjectSingleton.shared.cards.count > 0)
        tableView.reloadData()
    }
    
    func manageEmptyLabel(hidden: Bool) {
        if hidden, emptyDataLabel != nil {
            emptyDataLabel.removeFromSuperview()
            emptyDataLabel = nil
        } else if !hidden {
            emptyDataLabel = UILabel(frame: CGRect(x: 0.0, y: 110.0, width: UIScreen.main.bounds.width, height: 50.0)).emptyLabel(withText: "Ninguna tarjeta registrada")
            view.addSubview(emptyDataLabel)
        }
    }
}

// MARK: - Table View Data Source & Delegate -

extension CardsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectSingleton.shared.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.reuseIdentifier, for: indexPath) as! CardTableViewCell
        cell.card = ProjectSingleton.shared.cards[indexPath.row]
        cell.configureCell()
        if cell.card.isSelected {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        }
        return cell
    }
    
}
