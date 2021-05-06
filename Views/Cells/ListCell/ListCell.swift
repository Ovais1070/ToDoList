//
//  ListCell.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var list_Title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
