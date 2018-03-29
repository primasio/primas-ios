//
//  CommentFooter.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CommentFooter: BaseTableViewCell {

    @IBOutlet weak var loadMoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        loadMoreLabel.text = Rstring.cycle_des_more.localized() + ">"
    }

    static func cellHeight() -> CGFloat {
        return 40
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
