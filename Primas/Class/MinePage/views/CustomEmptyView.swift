//
//  CustomEmptyView.swift
//  Primas
//
//  Created by figs on 2017/12/24.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CustomEmptyView: UIControl {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func emptyView(height: CGFloat) -> CustomEmptyView{
        let view = CustomEmptyView.init(frame: CGRect.init(x: 0, y: 0, width: UIDevice.width(), height: height))
        view.originHeight = height
        return view
    }

    let imageView = UIImageView()
    let tipLbl = UILabel()
    let tipLbl2 = UILabel()
    
    let contentView = UIView()
    
    var originHeight: CGFloat!
    override init(frame: CGRect) {
        super.init(frame: frame)
        originHeight = self.height
        
        let height = 120 as CGFloat
        contentView.frame = CGRect.init(x: 0, y: (self.height-height)/2, width: self.width, height: height)
        self.addSubview(contentView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect.init(x: 0, y: 0, width: self.width, height: 80)
        contentView.addSubview(imageView)
        imageView.image = Rimage.empty_icon()
        
        tipLbl.frame = CGRect.init(x: 0, y: imageView.bottom+20, width: self.width, height: 20)
        tipLbl.font = UIFont.systemFont(ofSize: 13)
        tipLbl.textColor = Color_204
        tipLbl.textAlignment = .center
        contentView.addSubview(tipLbl)
        
        tipLbl2.frame = CGRect.init(x: 0, y: tipLbl.bottom-4, width: self.width, height: 26)
        tipLbl2.font = UIFont.systemFont(ofSize: 13)
        tipLbl2.textColor = Color_204
        tipLbl2.textAlignment = .center
        tipLbl2.text = Rstring.common_no_content.localized()
        contentView.addSubview(tipLbl2)
        
        contentView.height = tipLbl2.bottom
        
        contentView.top = (originHeight - contentView.height)/2
    }
    
    override var frame: CGRect{
        didSet{
            
        }
    }
    
    lazy var actionBtn : UIButton = {
        let btn = UIButton()
        btn.frame = CGRect.init(x: (self.width-200)/2, y: tipLbl2.bottom+10, width: 200, height: 26)
        btn.setTitleColor(Color_custom_red, for: .normal)
        let font = UIFont.systemFont(ofSize: 15)
        btn.titleLabel?.font = font
        btn.addTarget(self, action: #selector(onActionPressed), for: UIControlEvents.touchUpInside)
        let title = Rstring.cycle_go_write.localized()
        btn.setTitle(title, for: .normal)
        let width = title.getMaxWidth(font: font, height: btn.height)
        let line = UIView.init(frame: CGRect.init(x: (btn.width-width)/2, y: btn.height-4, width: width, height: 1))
        line.backgroundColor = Color_custom_red
        btn.addSubview(line)
        
        return btn
    }()
    
    
    func showMineEmpty() {
        
        tipLbl.text = Rstring.cycle_no_content.localized()
        tipLbl2.text = Rstring.cycle_no_content_tip.localized()
        
        tipLbl.textColor = Color_51
        tipLbl.font = UIFont.systemFont(ofSize: 15)
        
        tipLbl2.top = tipLbl.bottom + 20
        tipLbl2.textColor = Color_51
        tipLbl2.font = UIFont.systemFont(ofSize: 23)
        
        contentView.addSubview(actionBtn)
        
        contentView.height = actionBtn.bottom
        contentView.top = (originHeight - contentView.height)/2
        
    }
    func showCycleIndexEmpty() {
        tipLbl.text = Rstring.cycle_no_content.localized()
        tipLbl2.text = Rstring.cycle_no_content_tip.localized()
    }
    
    func showCycleEmpty() {
        
        tipLbl.text = Rstring.cycle_no_content.localized()
//        let baseStr = Rstring.cycle_no_content_tip.localized()
//        let att = NSMutableAttributedString.init(string: baseStr, attributes: [NSAttributedStringKey.font : tipLbl2.font, NSAttributedStringKey.foregroundColor: tipLbl2.textColor])
//        let str = Rstring.cycle_no_content_tip2.localized()
//        let range = baseStr.range(of: str)
//        let nsRange = baseStr.nsRange(from: range!)
//        att.addAttributes([NSAttributedStringKey.foregroundColor : Color_51], range: nsRange!)
//        tipLbl2.attributedText = att
        /*
        tipLbl.textColor = Color_204
        tipLbl.font = UIFont.systemFont(ofSize: 13)
        
        tipLbl2.top = tipLbl.bottom - 4
        tipLbl2.textColor = Color_204
        tipLbl2.font = UIFont.systemFont(ofSize: 13)
        actionBtn.isHidden = true
        
        contentView.height = tipLbl2.bottom
        contentView.top = (originHeight - contentView.height)/2
        */
    }
    
    
    @objc func onActionPressed(){
        self.sendActions(for: UIControlEvents.touchUpInside)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == actionBtn {
            return view
        }else if view == self{
            return self.superview
        }
        return nil
    }
}
