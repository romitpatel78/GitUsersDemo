//
//  UserListTableViewCell.swift
//  GitUsersDemo
//
//  Created by Romit Patel on 15/11/19.
//  Copyright © 2019 Romit Patel. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProfilePic : UIImageView!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblRepoCounts : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
