//
//  TableViewCell.swift
//  Alamofire123
//
//  Created by XongoLab on 10/10/18.
//  Copyright © 2018 XongoLab. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var LblFirst: UILabel!
    @IBOutlet weak var LblAddressid: UILabel!
    @IBOutlet weak var LblApt_Name: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
