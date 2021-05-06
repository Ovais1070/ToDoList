//
//  TopCell.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import UIKit

class TopCell: UITableViewCell {
    
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
