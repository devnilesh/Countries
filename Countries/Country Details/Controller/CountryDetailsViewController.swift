//
//  CountryDetailsViewController.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    var countryDetails : CountryViewModel?
    
    @IBOutlet weak var countryFlag : UIImageView!
    @IBOutlet weak var countryName : UILabel!
    @IBOutlet weak var capital : UILabel!
    @IBOutlet weak var callingCode : UILabel!
    @IBOutlet weak var region : UILabel!
    @IBOutlet weak var population : UILabel!
    @IBOutlet weak var timeZone : UILabel!
    @IBOutlet weak var currencies : UILabel!
    @IBOutlet weak var languages : UILabel!
    @IBOutlet weak var totalArea : UILabel!
    @IBOutlet weak var btnSave: UIControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    private func updateUI() {
        do {
            navigationItem.title = countryDetails?.name
            countryDetails?.loadImage({ (image) in
                self.countryFlag.image = image
            })
            countryName.text = countryDetails?.name
            capital.text = countryDetails?.capital
            callingCode.text = countryDetails?.callingCode
            region.text = countryDetails?.region
            population.text = countryDetails?.population
            timeZone.text = countryDetails?.timeZone
            currencies.text = countryDetails?.currencies
            languages.text = countryDetails?.languages
            totalArea.text = countryDetails?.totalArea
            btnSave.isHidden = try (self.countryDetails?.isOffline() ?? false)
            
        }
        catch {
            
        }
    }
    
    @IBAction func saveDetails(_ sender: Any) {
        do {
            try self.countryDetails?.save()
            self.navigationController?.popViewController(animated: true)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
