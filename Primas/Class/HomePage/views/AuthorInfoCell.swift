//
//  AuthorInfoCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class AuthorInfoCell: BaseTableViewCell {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var circleBtn: UIButton!
    var dtcpAction:NoneBlock?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.circleBtn.setBorderColor(color: UIColor.init(hex: "459c31"))
        self.circleBtn.setBorderWidth(width: 0.5)
        self.circleBtn.setCornerRadius(radius: 12)
        self.authorIcon.image = Utility.randomAvatar()
        self.authorIcon.setCornerRadius(radius: 20)
        
        circleBtn.addAction(.touchUpInside) {
            if self.dtcpAction != nil { self.dtcpAction!() }
        }
    }

    // MARK: - Cell height
    static func cellHeight() -> CGFloat {
        return 80
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
