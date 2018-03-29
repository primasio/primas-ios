//
//  CommentCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CommentCell: BaseTableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userIcon.setCornerRadius(radius: 15)
    }

    func setData(_ model: CommentModel) {
        timeLabel.text = model.CreatedAt?.toTimeString()
        contentLabel.text = model.Content == "" ? " " : model.Content
    }
    
    // MARK: - Cell height
    open static func cellHeight(_ model: CommentModel) -> CGFloat {
        let string = model.Content
        let font = UIFont.systemFont(ofSize: 15)
        let displayW = kScreenW - 76
        let contentH = Utility.getLabHeigh(
            string!,
            font: font,
            width: displayW)
        let addMargin:CGFloat = 75
        return addMargin + contentH
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
