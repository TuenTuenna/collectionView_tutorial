//
//  MyTableViewCell.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/09/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        print("MyTableViewCell - awakeFromNib() called")
        super.awakeFromNib()
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.height / 2
        
        
    }
    
}
