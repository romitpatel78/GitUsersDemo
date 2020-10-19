//
//  UserRepositoriesTableViewCell.swift
//  GitUsersDemo
//
//  Created by Romit Patel on 15/11/19.
//  Copyright © 2019 Romit Patel. All rights reserved.
//

import UIKit

class UserRepositoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRepoName : UILabel!
    @IBOutlet weak var lblForks : UILabel!
    @IBOutlet weak var lblRatings : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
