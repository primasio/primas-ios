//
//  ArticleGroup.swift
//  Primas
//
//  Created by wang on 15/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ArticleGroupComponent: UIView {
  let avatar: UIImageView = {
    let _image = UIImageView()
    return _image
  }()

  let groupName: UILabel = {
    return ViewTool.generateLabel("", 16.0, PrimasColor.shared.main.main_font_color)
  }()

  let contentNumber: UILabel = {
    return ViewTool.generateLabel("", 12.0, PrimasColor.shared.main.sub_font_color)
  }()

  let peopleNumber: UILabel = {
    return ViewTool.generateLabel("", 12.0, PrimasColor.shared.main.sub_font_color)
  }()

  let button: UIView = {
    let _view = UIView()
    _view.backgroundColor = hexStringToUIColor("#ed5f4b")

    let _label = ViewTool.generateLabel("去看看", 12.0)
    _view.addSubview(_label)

    _label.snp.makeConstraints {
      make in 
      make.center.equalTo(_view)
    }

    return _view
  }()

  func setup() {
    self.clipsToBounds = true
    setupViews()
    setupLayout()
  }

  func setupViews() {
    addSubview(avatar)
    addSubview(groupName)
    addSubview(contentNumber)
    addSubview(peopleNumber)
    addSubview(button)
  }

  func setupLayout() {
    self.backgroundColor = hexStringToUIColor("#f5f5f5")

    avatar.snp.makeConstraints {
      make in 
      make.left.top.equalTo(self).offset(MAIN_PADDING)
      make.size.equalTo(40.0)
    }

    groupName.snp.makeConstraints {
      make in 
      make.left.equalTo(avatar.snp.right).offset(MAIN_PADDING)
      make.top.equalTo(avatar)
    }

    contentNumber.snp.makeConstraints {
      make in 
      make.left.equalTo(groupName)
      make.bottom.equalTo(avatar)
    }

    peopleNumber.snp.makeConstraints {
      make in 
      make.left.equalTo(contentNumber.snp.right).offset(MAIN_PADDING)
      make.bottom.equalTo(contentNumber)
    }

    button.snp.makeConstraints {
      make in 
      make.centerY.equalTo(self)
      make.right.equalTo(self).offset(-MAIN_PADDING)
      make.size.equalTo(CGSize(width: 55.0, height: 25.0))
    }
  }

  func bind(imageUrl: String, name: String, contentNumber: Int, peopleNumber: Int) {
    let url = URL(string: imageUrl)
    avatar.kf.setImage(with: url)

    groupName.text = name
    self.contentNumber.text = "内容 \(contentNumber)"
    self.peopleNumber.text = "人数 \(peopleNumber)"
  }
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
