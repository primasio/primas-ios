//
//  PostCircleCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/28.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class PostCircleCell: BaseTableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var menbers: UILabel!
    @IBOutlet weak var contens: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var isSelectItem: Bool = false {
        didSet {
            selectButton.isSelected = isSelectItem
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icon.contentMode = .scaleAspectFill
        icon.setCornerRadius(radius: 2)
        icon.image = Utility.randomImg()
    }

    func setData(model: CycleModel)  {
        name.text = model.Title
        menbers.text = String(model.MemberCount) + Rstring.cycle_member.localized()
        contens.text = String(model.ArticleCount) + Rstring.cycle_content.localized()
    }
 
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
