//
//  EditToolBar.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/20.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class EditToolBar: UIView {

    var endEditBlock:NoneBlock?
    var selelctPhoto:NoneBlock?
    var openCarema:NoneBlock?
    
    @IBOutlet weak var closeKeyboard: UIButton!
    @IBOutlet weak var pickPhoto: UIButton!
    @IBOutlet weak var openCaremaBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Action
    @IBAction func endEdit(_ sender: Any) {
        if endEditBlock != nil {
            endEditBlock!()
        }
    }
    
    @IBAction func pickPhotoAction(_ sender: Any) {
        if selelctPhoto != nil {
            selelctPhoto!()
        }
    }
    
    @IBAction func openCaremaAction(_ sender: Any) {
        if openCarema != nil {
            openCarema!()
        }
    }
    
}
