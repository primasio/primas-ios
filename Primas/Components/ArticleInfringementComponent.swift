//
//  ArticleInfringement.swift
//  Primas
//
//  Created by wang on 15/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ArticleInfringementComponent: UIView {

  let viewContainer: UIView = {
    let _view = UIView()
    _view.layer.borderColor = PrimasColor.shared.main.red_font_color.cgColor
    _view.layer.borderWidth = 0.5
    _view.layer.cornerRadius = 2
    return _view
  }()

  let icon: UIImageView = {
    let _icon = UIImageView(image: UIImage(named: "notice-icon"))
    return _icon
  }()

  let tip: UILabel = {
    let _tip = UILabel()
    _tip.text = "发现一篇更早发布的相似内容"
    _tip.font = primasFont(14)
    _tip.textColor = PrimasColor.shared.main.red_font_color
    return _tip
  }()

  let title: UILabel = {
    let _title = UILabel()
    _title.font = primasFont(13)
    _title.textColor = PrimasColor.shared.main.sub_font_color
    return _title
  }()
    

  func setup() {
    self.clipsToBounds = true
    addSubview(viewContainer)
    viewContainer.addSubview(icon)
    viewContainer.addSubview(tip)
    viewContainer.addSubview(title)

    viewContainer.snp.makeConstraints {
        make in 
        make.left.right.bottom.top.equalTo(self)
    }

    icon.snp.makeConstraints {
        make in 
        make.left.equalTo(viewContainer).offset(SIDE_MARGIN)
        make.top.equalTo(viewContainer).offset(14)
    }

    tip.snp.makeConstraints {
        make in 
        make.left.equalTo(icon.snp.right).offset(5)
        make.top.equalTo(icon)
    }

    title.snp.makeConstraints {
        make in 
        make.left.equalTo(icon)
        make.bottom.equalTo(viewContainer ).offset(-SIDE_MARGIN)
        make.right.equalTo(viewContainer).offset(-SIDE_MARGIN)
    }

  }

  func bind(title: String) {
    self.title.text = "标题：\(title)"
  }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
