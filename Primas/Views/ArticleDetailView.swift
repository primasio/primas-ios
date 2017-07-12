//
//  ArticleDetail.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//
import SnapKit

class ArticleDetailView: UIView {
  let title: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(18)
    _label.textColor = PrimasColor.shared.main.main_font_color
    return _label
  }()
    
  let userImage: UIImageView = {
    let _view = UIImageView()
    _view.layer.cornerRadius = 35.0 / 2
    _view.clipsToBounds = true
    return _view
  }()

  let username: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(14)
    _label.textColor = PrimasColor.shared.main.main_font_color
    return _label
  }()

  let createdAt: UILabel = {
    let _label = UILabel()
    _label.textColor = PrimasColor.shared.main.sub_font_color
    _label.font = primasFont(10)
    return _label
  }()

  let content: UILabel = {
    let _label = UILabel()
    _label.textColor = PrimasColor.shared.main.main_font_color
    _label.font = primasFont(15)
    _label.numberOfLines = 0
    return _label
  }()

  func setupViews() {
    addSubview(title)
    addSubview(userImage)
    addSubview(username)
    addSubview(createdAt)
    addSubview(content)
  }

  func setupLayout() {
    title.snp.makeConstraints({
      make in 
      make.top.equalTo(self)
      make.left.right.equalTo(self)
    })

    userImage.snp.makeConstraints({
      make in 
      make.top.equalTo(title.snp.bottom).offset(20)
      make.left.equalTo(self)
      make.size.equalTo(CGSize(width: 35, height: 35))
    })

    username.snp.makeConstraints {
      make in 
      make.top.equalTo(userImage)
      make.left.equalTo(userImage.snp.right).offset(MAIN_PADDING)
    }

    createdAt.snp.makeConstraints {
      make in
      make.bottom.equalTo(userImage.snp.bottom)
      make.left.equalTo(username)
    }

    let _line = ViewTool.generateLine()
    addSubview(_line)

    _line.snp.makeConstraints {
      make in
      make.left.right.equalTo(self)
      make.top.equalTo(userImage.snp.bottom).offset(MAIN_PADDING)
    }

    content.snp.makeConstraints {
      make in
      make.left.equalTo(self).offset(3)
      make.right.equalTo(self)
      make.top.equalTo(_line.snp.bottom).offset(18)
    }

  }

  func setup() {
    setupViews()

    setupLayout()
  }

  func bind(_ article: ArticleDetailModel) {
    title.text = article.title
    username.text = article.username
    let imageUrl = URL(string: article.userImageUrl)
    self.userImage.kf.setImage(with: imageUrl)

    createdAt.text = primasDate("YYYY.MM.dd", article.createdAt)

    let paragraphStyle = NSMutableParagraphStyle()
    //line height size
    paragraphStyle.lineSpacing = 4
    let attrString = NSMutableAttributedString(string: article.content)
    attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
    content.attributedText = attrString
  }
}
