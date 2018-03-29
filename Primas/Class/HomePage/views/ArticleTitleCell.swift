//
//  ArticleTitleCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class ArticleTitleCell: BaseTableViewCell {

    @IBOutlet weak var contentTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    // MARK: - Cell height
    static func cellHeight(content:String) -> CGFloat {
        let string = content
        let font = UIFont.boldSystemFont(ofSize: 24)
        let topMargin:CGFloat = 20
        let boMargin:CGFloat = 30
        let margin:CGFloat = 20
        let displyWidth = kScreenW - margin * 2
        let height = Utility.getLabHeigh(string,
                                         font: font,
                                         width: displyWidth)
        return height + topMargin + boMargin
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
