//
//  ImageTextCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

public enum ImageTextCell_Display  {
    case ImageAndText
    case OnlyText
}

class ImageTextCell: BaseTableViewCell {

    @IBOutlet weak var authorIcon: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentImg: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleContent: UILabel!
    @IBOutlet weak var getValue: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var contentImgH: NSLayoutConstraint!
    @IBOutlet weak var titleTraling: NSLayoutConstraint!
    
    public var display:ImageTextCell_Display = .ImageAndText
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorIcon.image = Utility.randomAvatar()
        authorIcon.contentMode = .scaleAspectFill
        authorIcon.setCornerRadius(radius: 14)
        configureTextDisply()
    }

    func slectDisplay(display: ImageTextCell_Display)  {
        self.display = display
        configureTextDisply()
    }
    
    fileprivate func configureTextDisply()  {
        if display == .OnlyText {
            contentImgH.constant = 0
            titleTraling.constant = 0
        } else {
            contentImgH.constant = 95
            titleTraling.constant = 30
        }
    }
    
    // MARK: - set data
    func setModel(articleModel: ArticelModel)  {
        self.display = ImageTextCell.selectDislplay(articleModel)
        configureTextDisply()
        articleTitle.text = articleModel.Title
        authorName.text = articleModel.Author?.Name == "" ? "unknow" : articleModel.Author?.Name
        articleContent.text = articleModel.Abstract
        likeLabel.text = articleModel.LikeCount
        commentLabel.text = articleModel.CommentCount
        shareLabel.text = articleModel.ShareCount
        getValue.text = (articleModel.TotalIncentives?.isEmpty)! ? "0" : articleModel.TotalIncentives?.toPstValue()
        if articleModel.TxStatus == "1" {
            timeLabel.text  = Rstring.post_to_auditting.localized()
        } else {
            timeLabel.text = articleModel.CreatedAt?.toTimeString()
        }
    }
    
    
    static func selectDislplay(_ articleModel: ArticelModel) -> ImageTextCell_Display{
        return .OnlyText
    }
    
    static func getCellHeight(articleModel: ArticelModel) -> CGFloat {
        
        let title = articleModel.Title
        let content = articleModel.Abstract
        let leftmargin:CGFloat = 15
        let title_font = UIFont.boldSystemFont(ofSize: 17)
        let content_font = UIFont.systemFont(ofSize: 13)
        let addheight:CGFloat = 125
        var imageW:CGFloat = 0
        var image_l:CGFloat = 0
        
        if self.selectDislplay(articleModel) == .ImageAndText {
            imageW = 95
            image_l = 30
        } else {
            imageW = 0
            image_l = 0
        }
        let title_dis_w = kScreenW - leftmargin * 2 - imageW - image_l
        let title_height = Utility.getLabHeigh(title!, font: title_font, width: title_dis_w)
        var content_height:CGFloat = 10
        if !(content?.isEmpty)! {
            content_height = Utility.getLabHeigh(content!, font: content_font, width: title_dis_w)
        }
        return title_height + content_height + addheight
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
