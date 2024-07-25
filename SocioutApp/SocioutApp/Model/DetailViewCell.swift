//
//  DetailViewCell.swift
//  SocioutApp
//
//  Created by swati mane on 14/09/22.
//

import UIKit

class DetailViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var nameLable: UITextField!
    @IBOutlet weak var emailLable: UITextField!
    @IBOutlet weak var textPostL: UITextField!
    @IBOutlet weak var bodyFeildL: UITextField!
    @IBOutlet weak var commentPost: UITextField!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
