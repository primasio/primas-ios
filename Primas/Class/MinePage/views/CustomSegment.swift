//
//  CustomOptionView.swift
//  Primas
//
//  Created by figs on 2017/12/24.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class CustomSegment: UIControl {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let leftItem = UIButton()
    let rightItem = UIButton()
    let selectedMask = UIView()
    var selectedColor = Color_custom_red {
        didSet{
            updateItemsState()
            selectedMask.backgroundColor = selectedColor
        }
    }
    var normalColor = Color_title_black{
        didSet{
            updateItemsState()
        }
    }
    
    
    func initSubvews() {
        self.backgroundColor = UIColor.white
        var rect = self.bounds
        rect.size.width = kScreenW / 2
        leftItem.frame = rect
        leftItem.addTarget(self, action: #selector(onItemPressed(item:)),
                           for: .touchUpInside)
        leftItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(leftItem)
        
        rect.origin.x += leftItem.width
        rightItem.frame = rect
        rightItem.addTarget(self, action: #selector(onItemPressed(item:)),
                            for: .touchUpInside)
        rightItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(rightItem)
    
        rect.size.height = 1.5
        rect.origin.x = 0
        rect.origin.y = self.height - rect.size.height
        selectedMask.frame = rect
        selectedMask.backgroundColor = selectedColor
        self.addSubview(selectedMask)
        updateItemsState()
//        self.addBorder(color: Color_219, size: 0.5, borderTypes: [BorderType.bottom.rawValue])
    }
    
    var selectedIndex = 0 {
        didSet{
            if oldValue == selectedIndex{
                return
            }
            updateItemsState()
        }
    }
    
    func updateTitle(left: String?, right: String?){
        leftItem.setTitle(left, for: .normal)
        rightItem.setTitle(right, for: .normal)
    }
    
    func updateItemsState() {
        if selectedIndex == 0 {
            leftItem.setTitleColor(selectedColor, for: .normal)
            rightItem.setTitleColor(normalColor, for: .normal)
        }else {
            rightItem.setTitleColor(selectedColor, for: .normal)
            leftItem.setTitleColor(normalColor, for: .normal)
        }
    }
    
    @objc func onItemPressed(item: UIButton){
        self.selectedIndex = item == leftItem ? 0 : 1
        self.sendActions(for: UIControlEvents.valueChanged)
    }
}
