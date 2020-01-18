//
//  LandingScreenViewController.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class LandingScreenViewController: UIViewController {
    @IBOutlet weak var countriesTable : UITableView!
    
    private let viewModel = LandingScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.searchCountryBy("India")
    }
    
    // MARK:- Private Interface
    private func setupTableView() {
        self.viewModel.loadTestModels()
        // Setting up this line to remove all the unnecessory separator lines from tableview
        self.countriesTable.tableFooterView = UIView()
    }
    
}

extension LandingScreenViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: String(describing:CountryTableViewCell.self)) as! CountryTableViewCell
        tableCell.country = self.viewModel.countryFor(row: indexPath.row)
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
}

extension LandingScreenViewController : UITableViewDelegate {
    
}
