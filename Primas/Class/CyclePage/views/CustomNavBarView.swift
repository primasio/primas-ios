//
//  CustomNavBarView.swift
//  Primas
//
//  Created by figs on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit


@objc  protocol CustomNavBarViewDelegate: NSObjectProtocol {
    @objc optional  func leftAction()
    @objc optional  func rightAction()
}

class CustomNavBarView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func navBar() -> CustomNavBarView{
        let height = UIDevice.navTopOffset()
        let bar = CustomNavBarView.init(
            frame: CGRect.init(x: 0, y: 0, width: UIDevice.width(), height: height))
        return bar
    }
    
    var delegate: CustomNavBarViewDelegate?
    
    var leftBtn: UIButton!
    var rightBtn: UIButton!
    var titleLbl: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let topOffset = UIDevice.statusTopOffset()
        let barHeight = 44 as CGFloat
        self.leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: topOffset, width: barHeight*2, height: barHeight))
        leftBtn.contentHorizontalAlignment = .left
        leftBtn.setImage(Rimage.back()?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        leftBtn.tintColor = UIColor.white
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(leftBtn)
        leftBtn.addTarget(self, action: #selector(leftAction), for: .touchUpInside)
        let margin:CGFloat = 5
        self.rightBtn = UIButton.init(frame: CGRect.init(x: self.width-barHeight*2 - margin, y: topOffset, width: barHeight*2, height: barHeight))
        rightBtn.contentHorizontalAlignment = .right
        rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10)
        self.addSubview(rightBtn)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.addTarget(self, action: #selector(rightAction), for: .touchUpInside)
        //rightBtn.setImage(Rimage.shezhi(), for: .normal)
        
        self.titleLbl = UILabel.init(frame: CGRect.init(x: leftBtn.right + 10, y: topOffset, width: rightBtn.left - 20 - leftBtn.right, height: barHeight))
        self.addSubview(titleLbl)
        titleLbl.textColor = UIColor.clear
        titleLbl.textAlignment = .center
        titleLbl.font = UIFont.boldSystemFont(ofSize: 17)
        
    }
    
    var isInRootView = false {
        didSet{
            leftBtn.isHidden = isInRootView
        }
    }
    
    var title: String!{
        didSet{
            titleLbl.text = title
        }
    }
    
    var showColor: UIColor!{
        didSet{
            leftBtn.tintColor = showColor
            rightBtn.tintColor = showColor
        }
    }
    
    @objc func leftAction() {
        delegate?.leftAction?()
    }
    
    @objc func rightAction() {
        delegate?.rightAction?()
    }
    
    var customAlpha: CGFloat!{
        didSet{
            updateBackgroundColor(percentage: customAlpha)
            updateTintColor(percentage: customAlpha)
        }
    }
    
    func updateBackgroundColor(percentage: CGFloat) {
        let alpha = max(0, percentage)
        self.backgroundColor = UIColor.init(white: 1, alpha: alpha)
    }
    
    func updateTintColor(percentage: CGFloat) {
        let alpha = max(0, percentage)
        titleLbl.textColor = UIColor.init(white: 0, alpha: alpha)
        let color = getColorFrom(UIColor.white, UIColor.black, alpha)
        self.showColor = color
    }
    
    @objc func getColorFrom(_ f: UIColor, _ to: UIColor, _ p: CGFloat) -> UIColor {
        var r:CGFloat=0, g:CGFloat=0, b:CGFloat=0, a:CGFloat=0
        f.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        var tr:CGFloat=0, tg:CGFloat=0, tb:CGFloat=0, ta:CGFloat=0
        to.getRed(&tr, green: &tg, blue: &tb, alpha: &ta)
        
        let lr = tr - r
        let lg = tg - g
        let lb = tb - b
        let la = ta - a
        
        let p = min(p, 1)
        r = r + lr*p
        g = g + lg*p
        b = b + lb*p
        a = a + la*p
        
        let color = UIColor.init(red: r, green: g, blue: b, alpha: a)
        return color
    }
}
