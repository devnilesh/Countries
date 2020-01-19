//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit
import SVGKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryFlag : UIImageView!
    @IBOutlet weak var countryName : UILabel!
    
    var country : CountryViewModel? {
        didSet{
            self.updateUI()
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI() {
        self.countryName.text = country?.name
        self.countryFlag.image = UIImage(named: "placeholder")
        self.country?.loadImage({ (image) in
            self.countryFlag.image = image
        })
    }
    
}

