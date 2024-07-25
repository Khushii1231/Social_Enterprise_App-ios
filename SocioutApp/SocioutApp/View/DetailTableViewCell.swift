//
//  detailTableViewCell.swift
//  SocioutApp
//
//  Created by swati mane on 10/09/22.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLable: UITextField!
    @IBOutlet weak var emailLable: UITextField!
    @IBOutlet weak var textPostL: UITextField!
    @IBOutlet weak var bodyFeildL: UITextField!
    @IBOutlet weak var commentPost: UITextField!
    
     override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
