//
//  ArticleContent.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import BonMot

class ArticleContent: BaseTableViewCell {

    @IBOutlet weak var contentTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
    }

    func setContent(content: String)  {
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 10
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16),
                          NSAttributedStringKey.paragraphStyle: paraph,
                          NSAttributedStringKey.foregroundColor: Rcolor.c666666()]
        let att = NSAttributedString.init(string: content, attributes: attributes)
        self.contentTextView.attributedText = att
    }
    
    // MARK: - Cell height
    static func cellHeight(content:String) -> CGFloat {
        
        let string = content
        let margin:CGFloat = 20
        let displyWidth = kScreenW - margin * 2
        
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 10
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedStringKey.font: font,
                          NSAttributedStringKey.paragraphStyle: paraph]
        
        let height = string.boundingRect(
            with: CGSize(width: displyWidth, height: 10000),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil).size.height
        
        return height + margin
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
