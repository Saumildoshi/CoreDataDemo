//
//  UsersTableViewCell.swift
//  DemoCore
//
//  Created by Saumil on 23/07/24.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var txtName: UILabel!
    
    @IBOutlet weak var txtAddress: UILabel!
    
    @IBOutlet weak var txtCity: UILabel!
    
    @IBOutlet weak var txtMobileNumber: UILabel!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
