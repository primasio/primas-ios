//
//  MineCycleCell.swift
//  Primas
//
//  Created by figs on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class MineCycleCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var cycleIcon: UIImageView!
    @IBOutlet weak var cycleTitle: UILabel!
    @IBOutlet weak var cycleInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.setCornerRadius(radius: 5)
        self.backgroundColor = UIColor.clear
        cycleIcon.image = Utility.randomImg()
        cycleIcon.contentMode = .scaleAspectFill
        cycleIcon.layer.masksToBounds = true
    }

    var model: CycleModel!{
        didSet {
            cycleTitle.text = model.Title;
            cycleInfo.text =  Rstring.cycle_content_num.localized().replace(of: "%d", with: "\(model.MemberCount)");
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
