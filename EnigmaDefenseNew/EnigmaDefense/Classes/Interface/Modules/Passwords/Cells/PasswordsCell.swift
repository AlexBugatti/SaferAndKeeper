//
//  PasswordsCell.swift
//  MiSecure
//
//  Created by Александр on 10.05.2021.
//

import UIKit

class PasswordsCell: UITableViewCell {

    var didShowTapped: (() -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onDidShowTapped(_ sender: Any) {
        self.didShowTapped?()
    }
    
}
