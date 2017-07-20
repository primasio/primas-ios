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
    _label.numberOfLines = 0
    
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
    
  let _line = ViewTool.generateLine()

    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    

  func setupViews() {
    scrollView.isScrollEnabled = true
    scrollView.isUserInteractionEnabled = true
    scrollView.showsVerticalScrollIndicator = true
    scrollView.bounces = true
    scrollView.alwaysBounceVertical = true
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.backgroundColor = UIColor.white
    
    self.addSubview(scrollView)
    
    scrollView.addSubview(infringementView)

    scrollView.addSubview(title)
    scrollView.addSubview(userImage)
    scrollView.addSubview(username)
    scrollView.addSubview(createdAt)
    scrollView.addSubview(DNA)
    scrollView.addSubview(_line)
    
    scrollView.addSubview(groupLabel)
    scrollView.addSubview(group)
    
  }

  func setupLayout() {
    
    scrollView.snp.makeConstraints {
        make in
        make.left.right.equalTo(self)
        make.top.bottom.equalTo(self)
    }
    
    // notice: remark
    infringementView.snp.makeConstraints {
      make in
      make.left.equalTo(scrollView).offset(SIDE_MARGIN)
      make.right.equalTo(scrollView).offset(-SIDE_MARGIN)
      make.top.equalTo(scrollView).offset(SIDE_MARGIN)
  make.size.width.equalTo(scrollView).inset(UIEdgeInsets(top: SIDE_MARGIN, left: SIDE_MARGIN, bottom: scrollView.frame.height, right: SIDE_MARGIN))
    }
    
    title.snp.makeConstraints({
      make in 
      make.top.equalTo(infringementView.snp.bottom).offset(25)
      make.left.right.equalTo(infringementView)
    })

    userImage.snp.makeConstraints({
      make in 
      make.top.equalTo(title.snp.bottom).offset(20)
      make.left.equalTo(infringementView)
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
      make.right.equalTo(infringementView)
      make.size.equalTo(CGSize(width: 120, height: 29))
    }

    _line.snp.makeConstraints {
      make in
      make.left.right.equalTo(infringementView)
      make.top.equalTo(userImage.snp.bottom).offset(MAIN_PADDING)
    }

    group.snp.makeConstraints {
        make in 
        make.bottom.equalTo(scrollView).offset(-SIDE_MARGIN)
        make.size.height.equalTo(0)
    }

    groupLabel.snp.makeConstraints {
        make in 
        make.bottom.equalTo(group.snp.top).offset(-20)
        make.size.height.equalTo(0)
    }
  }

  func setup() {
    setupViews()
    setupLayout()
  }

  func bind(_ article: ArticleDetailModel) {
    self.title.text = article.title
    username.text = article.username
    let imageUrl = URL(string: article.userImageUrl)
    self.userImage.kf.setImage(with: imageUrl)

    createdAt.text = primasDate("YYYY.MM.dd", article.createdAt)

    if article.DNA == "" {
      DNA.snp.remakeConstraints {
        make in
        make.size.equalTo(0)
      }
    } else {
       let _label =  DNA.subviews[0] as! UILabel
        _label.text = "DNA \(article.DNA)"
    }
    
    var prev:UIView? = nil
    
    article.content.forEach {
        body in
        
        let item = body as! [String: String]
        
        if(item["type"] == "p")
        {
            let p = UILabel()
            p.attributedText = primasFontSpace(text: item["text"]!, font: primasFont(16))
            p.numberOfLines = 0
            p.textColor = PrimasColor.shared.main.main_font_color
            
            scrollView.addSubview(p)
            
            p.snp.makeConstraints {
                make in
                
                make.left.right.equalTo(infringementView)
                
                if let pr = prev
                {
                    make.top.equalTo(pr.snp.bottom).offset(MAIN_PADDING)
                }else{
                    make.top.equalTo(_line.snp.bottom).offset(18)
                }
            }
            
            prev = p
            
        } else {
            let _image  = UIImageView()
            let url = URL(string: app().client.baseURL + item["src"]!)
            _image.backgroundColor = UIColor.red
            _image.kf.setImage(with: url)
            _image.contentMode = .scaleAspectFit
            _image.clipsToBounds = true
            scrollView.addSubview(_image)

            _image.snp.makeConstraints {
                make in 
                make.left.right.equalTo(infringementView)
                make.centerX.equalTo(infringementView)
                if let pr = prev {
                    make.top.equalTo(pr.snp.bottom).offset(5.0)
                } else {
                    make.top.equalTo(_line.snp.bottom).offset(18)
            }
            }
        
         prev = _image

        }
    }
    
    if let pr = prev
    {
        pr.snp.makeConstraints {
            make in
            make.bottom.equalTo(groupLabel.snp.top).offset(-30)
        }
    }else{
        _line.snp.makeConstraints {
            make in
            make.bottom.equalTo(groupLabel.snp.top).offset(-30)
        }
    }
    
  }

  func bindInfringement(title: String) {
    infringementView.bind(title: title)
    
    let _height = app().navigation.navigationBar.frame.height
    let _statusbar_height = UIApplication.shared.statusBarFrame.height
    
    infringementView.snp.remakeConstraints {
      make in
      make.left.equalTo(scrollView).offset(SIDE_MARGIN)
      make.right.equalTo(scrollView).offset(-SIDE_MARGIN)
      make.top.equalTo(scrollView).offset(SIDE_MARGIN)
      make.size.width.equalTo(scrollView).inset(UIEdgeInsets(top: SIDE_MARGIN, left: SIDE_MARGIN, bottom: scrollView.frame.height - 70 - _height - _statusbar_height - SIDE_MARGIN, right: SIDE_MARGIN))
    }

    DNA.snp.remakeConstraints {
        make in
        make.size.equalTo(0)
    }
  }
    
  func bindGroup(imageUrl: String, name: String, contentNumber: Int, peopleNumber: Int) {
    self.group.bind(imageUrl: imageUrl, name: name, contentNumber: contentNumber, peopleNumber: peopleNumber)

    
    group.snp.remakeConstraints {
      make in 
      make.bottom.equalTo(scrollView.snp.bottom).offset(-SIDE_MARGIN)
      make.left.equalTo(infringementView)
      make.right.equalTo(infringementView)
      make.size.height.equalTo(60.0)
    }


    groupLabel.snp.remakeConstraints {
      make in 
      make.left.equalTo(infringementView)
      make.bottom.equalTo(group.snp.top).offset(-20)
    }

  }
}


