//
//  TableViewCell.swift
//  SocioutApp
//
//  Created by swati mane on 07/09/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var bodyPostLable: UILabel!
    
    @IBOutlet weak var titlePostLable: UILabel!
    
    var textL = ""
    var bodyL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bodyPostLable.text = textL
        titlePostLable.text = bodyL
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
      

}
