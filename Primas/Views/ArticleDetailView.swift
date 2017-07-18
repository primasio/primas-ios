//
//  ArticleDetail.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//
import SnapKit

class ArticleDetailView: UIView {
    
  var isInfringement: Bool = false  
    
  let infringementView = ArticleInfringementComponent()
    
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

  let DNA: UIView = {
    let _view = UIView()
    _view.backgroundColor = hexStringToUIColor("#34dc28")

    let _label = UILabel()
    _label.textColor = UIColor.white
    _label.font = primasFont(14)

    _view.addSubview(_label)

    _label.snp.makeConstraints {
      make in 
      make.center.equalTo(_view)
    }

    return _view
  }()

  let groupLabel: UILabel = {
    return ViewTool.generateLabel("文章来自社群", 14.0, PrimasColor.shared.main.light_font_color)
  }()

  let group = ArticleGroupComponent()

  let content: UILabel = {
    let view = UILabel()
    return view
  }()
    
  let _line = ViewTool.generateLine()


  func setupViews() {
    addSubview(infringementView)
    
    addSubview(title)
    addSubview(userImage)
    addSubview(username)
    addSubview(createdAt)
    addSubview(DNA)
    addSubview(_line)
    addSubview(content)
    
    addSubview(groupLabel)
    addSubview(group)
  }

  func setupLayout() {
    infringementView.snp.makeConstraints {
      make in
      make.left.right.equalTo(self)
      make.top.equalTo(self)
      make.size.height.equalTo(0.01)
    }
    
    title.snp.makeConstraints({
      make in 
      make.top.equalTo(infringementView.snp.bottom).offset(25)
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
      make.left.equalTo(userImage.snp.right).offset(SIDE_MARGIN)
    }

    createdAt.snp.makeConstraints {
      make in
      make.bottom.equalTo(userImage.snp.bottom)
      make.left.equalTo(username)
    }
    
    DNA.snp.makeConstraints {
      make in 
      make.bottom.equalTo(createdAt)
      make.right.equalTo(self)
      make.size.equalTo(CGSize(width: 110, height: 29))
    }


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
      make.size.width.equalTo(self)
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

   
    content.text = article.content

    if article.DNA == "" {
      DNA.snp.remakeConstraints {
        make in 
        make.size.equalTo(0)
      }
    } else {
       let _label =  DNA.subviews[0] as! UILabel
        _label.text = "DNA \(article.DNA)"
    }
  }

  func bindInfringement(title: String) {
    infringementView.bind(title: title)

    infringementView.snp.remakeConstraints {
      make in
      make.left.right.equalTo(self)
      make.top.equalTo(self).offset(SIDE_MARGIN)
      make.size.height.equalTo(70)
    }
  }

  func bindGroup(imageUrl: String, name: String, contentNumber: Int, peopleNumber: Int) {
    self.group.bind(imageUrl: imageUrl, name: name, contentNumber: contentNumber, peopleNumber: peopleNumber)

    groupLabel.snp.remakeConstraints {
      make in 
      make.left.equalTo(content)
      make.top.equalTo(content.snp.bottom).offset(60)
    }

    group.snp.remakeConstraints {
      make in 
      make.top.equalTo(groupLabel.snp.bottom).offset(20)
      make.left.equalTo(self)
      make.right.equalTo(self)
      make.size.height.equalTo(60.0)
    }

  }

}


