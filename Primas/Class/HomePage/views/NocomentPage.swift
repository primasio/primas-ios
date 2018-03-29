//
//  NocomentPage.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/10.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit
import BonMot

class NocomentPage: UIView {

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        label.attributedText = Utility.emptyAttributed(Rstring.common_no_comment.localized())
    }

}
