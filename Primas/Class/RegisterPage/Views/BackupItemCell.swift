//
//  BackupItemCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/27.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

enum BackupItemCell_Style {
    case white_style
    case red_style
}

class BackupItemCell: UITableViewCell {

    var display:BackupItemCell_Style = .white_style
    var handleAction:NoneBlock?
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var subtitle2: UILabel!
    @IBOutlet weak var subTitle3: UILabel!
    @IBOutlet weak var level1: UILabel!
    @IBOutlet weak var level2: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        button.setCornerRadius(radius: 5)
        button.setBorderWidth(width: 0.5)
        subtitle.isHidden = true
    }

    func setItem(l1:String, l2: String, buttonName:String, style:String)  {
        level1.text = l1
        level2.text = l2
        button.setTitle(buttonName, for: .normal)
        
        if style == "1" {
            button.setBorderColor(color: Rcolor.ed5634())
            button.backgroundColor = UIColor.white
            button.setTitleColor(Rcolor.ed5634(), for: .normal)
        } else  {
            button.setBorderColor(color: Rcolor.ed5634())
            button.backgroundColor = Rcolor.ed5634()
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        if handleAction != nil {
            handleAction!()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
