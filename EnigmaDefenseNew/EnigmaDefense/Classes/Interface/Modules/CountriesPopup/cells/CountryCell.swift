//
//  CoutryCell.swift
//  EnigmaDefense
//
//  Created by Александр on 21.04.2021.
//

import UIKit

class CountryCell: UITableViewCell {

    var onDidSelectTapped: (() -> Void)?
    var onDidFavoriteTapped: (() -> Void)?
    
    @IBOutlet weak var countryIconView: UIImageView!
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var favoriteView: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(country: VPNCountry) {
        self.countryTitle.text = country.country.rawValue
        self.countryIconView.image = UIImage(named: country.country.rawValue)
        
        let image = country.isFavorite ? UIImage(named: "favorite-selected") : UIImage(named: "favorite")
        self.favoriteView.setImage(image, for: .normal)
    }
    
    @IBAction func onDidSelectTapped(_ sender: Any) {
        self.onDidSelectTapped?()
    }
    
    @IBAction func onDidFavoriteTapped(_ sender: Any) {
        self.onDidFavoriteTapped?()
    }
    
    
}
