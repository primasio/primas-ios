//
//  CommentToolBar.swift
//  Primas
//
//  Created by xuxiwen on 2018/1/9.
//  Copyright © 2018年 xuxiwen. All rights reserved.
//

import UIKit

class CommentToolBar: UIView {

    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var contentBlock: StringBlock?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.setCornerRadius(radius: 16)
        textFiled.delegate = self
        KeyboardManager.enAbleToolBar()
        
        commentButton.addAction(.touchUpInside) {
            if self.contentBlock != nil {
                self.contentBlock!(self.textFiled.text!)
            }
        }
    }

}

extension CommentToolBar: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.contentBlock != nil {
            self.contentBlock!(self.textFiled.text!)
        }
        return false
    }
}

