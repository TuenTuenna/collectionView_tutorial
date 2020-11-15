//
//  MyCollectionViewCell.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/11/15.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit
class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var profileLabel: UILabel!

    var imageName : String = "" {
        didSet{
            print("MyCollectionViewCell / imageName - didSet() : \(imageName)")
            // 쏄의 UI 설정
            self.profileImg.image = UIImage(systemName: imageName)
            self.profileLabel.text = imageName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyCollectionViewCell - awakeFromNib() called")
        self.contentView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        self.contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
    }
    
}
