//
//  MenuCell.swift
//  Lagree
//
//  Created by alk msljc on 9/25/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var itemTitle: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
