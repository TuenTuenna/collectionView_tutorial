//
//  MyCustomCollectionViewCell.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/11/15.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit
class MyCustomCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var profileLabel: UILabel!
    @IBOutlet var profileImg: UIImageView!
    
    var imageName : String = "" {
        didSet{
            print("MyCustomCollectionViewCell / imageName - didSet() : \(imageName)")
            // 쏄의 UI 설정
            self.profileImg.image = UIImage(systemName: imageName)
            self.profileLabel.text = imageName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyCustomCollectionViewCell - awakeFromNib() called")
        self.contentView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }
    
}
