//
//  CommentHeader.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CommentHeader: BaseTableViewCell {

    @IBOutlet weak var commentTitle: UILabel!
    @IBOutlet weak var commentNum: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        commentTitle.text = Rstring.common_comment.localized()
    }

    static func cellHeight() -> CGFloat {
        return 35
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
