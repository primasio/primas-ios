//
//  TagCollectionCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

public enum Tags_Display {
    case show
    case select
    case selected
}

class TagCollectionCell: UICollectionViewCell {

    @IBOutlet weak var tagmaskView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    public var display:Tags_Display = .show
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagmaskView.setCornerRadius(radius: 2)
        setTags(display: display)
     }

    // MARK: - set style
    public func setTags(display:Tags_Display)  {
        self.display = display
        switch display {
        case .show:
            tagmaskView.setBorderWidth(width: 0)
            tagmaskView.setBorderColor(color:  Rcolor.f2F2F2())
            tagmaskView.backgroundColor = Rcolor.f2F2F2()
            break
        case .select:
            tagmaskView.setBorderWidth(width: 0.5)
            tagmaskView.setBorderColor(color:  Rcolor.cccccC())
            tagmaskView.backgroundColor = UIColor.white
            contentLabel.textColor = Rcolor.c666666()
            break
        case .selected:
            tagmaskView.setBorderWidth(width: 0.5)
            let color = Color_0ded5634
            tagmaskView.setBorderColor(color: Rcolor.ed5634())
            tagmaskView.backgroundColor = color
            contentLabel.textColor = Rcolor.ed5634()
            break
        }
    }
}
