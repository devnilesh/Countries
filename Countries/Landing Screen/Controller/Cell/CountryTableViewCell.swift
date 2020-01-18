//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Nilesh Mahajan on 18/01/20.
//  Copyright © 2020 Nilesh Mahajan. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryFlag : UIImageView!
    @IBOutlet weak var countryName : UILabel!
    
    var country : CountryViewModel? {
        didSet{
            self.updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateUI() {
        self.countryFlag.image = country?.flagImage
        self.countryName.text = country?.name
    }

}
