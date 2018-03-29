//
//  DetailPageCircle.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class DetailPageCircle: BaseTableViewCell {

    @IBOutlet weak var circleName: UILabel!
    @IBOutlet weak var circleIcon: UIImageView!
    @IBOutlet weak var circleContent: UILabel!
    @IBOutlet weak var getValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circleIcon.image = Utility.randomImg()
        circleIcon.contentMode = .scaleAspectFill
        circleIcon.setCornerRadius(radius: 3)
        self.selectionStyle = .none
        circleName.text = Rstring.cycle_title.localized() + ": "
    }

    // MARK: - Cell height
    static func cellHeight(circle: CycleModel) -> CGFloat {
        if circle.ID == nil { return 0 }
        return 38
    }
    
    func setData(circle: CycleModel)  {
        if circle.ID != nil {
            circleContent.text = circle.Title
        }
    }
    
    func setValue(str: String)  {
        getValue.text = str.isEmpty ? "0" : str.toPstValue()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
