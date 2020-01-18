//
//  LandingScreenViewController.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class LandingScreenViewController: UIViewController {
    @IBOutlet weak var errorMessage : UILabel!
    @IBOutlet weak var errorView : UIView!
    @IBOutlet weak var countriesTable : UITableView!
    @IBOutlet weak var searchField : UITextField!
    
    private let viewModel = LandingScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.addKeyboardObservers()
        self.setupGestureRecognizer()
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        self.removeKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK:- Private Interface
    private func setupTableView() {
        // Setting up this line to remove all the unnecessory separator lines from tableview
        self.countriesTable.tableFooterView = UIView()
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
    }

    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard));
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func showError(_ message: String) {
        errorView.isHidden = (message.count == 0)
        errorMessage.text = message
    }
    
    @objc private func dismissKeyboard() {
        self.searchField?.resignFirstResponder()
    }
    
    @objc private func keyboardDidShow(_ notification : NSNotification) {
        if let activeField = self.searchField {
            
            if let keyboardSize = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
                countriesTable.contentInset = contentInsets
                countriesTable.scrollIndicatorInsets = contentInsets
                
                var activeFieldFrame = activeField.frame
                
                if let superview = activeField.superview {
                    activeFieldFrame.origin.y = superview.convert(activeFieldFrame, to: self.countriesTable).origin.y
                }
                countriesTable.scrollRectToVisible(activeFieldFrame, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification : NSNotification) {
        let contentInsets = UIEdgeInsets.zero;
        self.countriesTable.contentInset = contentInsets;
        self.countriesTable.scrollIndicatorInsets = contentInsets;
    }
    
    private func displayCountry(_ details: CountryViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: CountryDetailsViewController.self)) as! CountryDetailsViewController
        controller.countryDetails = details
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    @IBAction func dismissErrorView(_ sender: Any?) {
        self.showError("")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let countryDetails = self.viewModel.countryFor(row: indexPath.row) {
            self.displayCountry(countryDetails)
        }
    }
}

extension LandingScreenViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) {
            self.viewModel.searchCountryBy(updatedString) { error in
                self.showError(error ?? "")
                self.countriesTable.reloadData()
            }
        }
        return true
    }
}

extension LandingScreenViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view is UIButton || touch.view is UIControl {
            return false
        }
        return true
    }
}
