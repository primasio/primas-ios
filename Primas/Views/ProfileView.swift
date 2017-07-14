//
//  ProfileView.swift
//  Primas
//
//  Created by wang on 13/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    var controler: ValueViewController?

    let headerViewContainer: UIView = {
      let _view = UIView()
      _view.backgroundColor = UIColor(patternImage: UIImage(named: "profile-bg")!)
      return _view
    }()

    let userImage: UIImageView = {
      let _image = UIImageView()
      _image.layer.borderWidth = 1.0
      _image.layer.borderColor = hexStringToUIColor("#cd5e3f").cgColor
      _image.clipsToBounds = true
      _image.layer.cornerRadius = 30.0
      return _image
    }()

    let username: UILabel = {
      let _label = UILabel()
      _label.font = primasFont(17)
      _label.textColor = UIColor.white
      _label.textAlignment = .center
      return _label
    }()

    let profileIndex: UILabel = {
      let _label = UILabel()
      _label.clipsToBounds = true
      _label.font = primasFont(11)
      _label.backgroundColor = UIColor.white
      _label.textColor = PrimasColor.shared.main.red_font_color
      _label.layer.cornerRadius = 6
      return _label
    }()

    let vline: UIView = {
      return ViewTool.generateLine(hexStringToUIColor("#ff886c"), 36.0)
    }()

    let hpIcon: UIImageView = {
       return UIImageView(image: UIImage(named: "hp-icon"))
    }()

    let primasIcon: UIImageView = {
      return UIImageView(image: UIImage(named: "pst-icon"))
    }()

    let hpLabel: UILabel = {
      return ViewTool.generateLabel("HP值", 12.0, hexStringToUIColor("#ffcec2"))
    }()

    let primasLabel: UILabel = {
      return ViewTool.generateLabel("PST总额", 12.0, hexStringToUIColor("#ffcec2"))
    }()

    let hpValue: UILabel = {
      return ViewTool.generateLabel("", 16.0)
    }()

    let pstValue: UILabel = {
      return ViewTool.generateLabel("", 16.0)
    }()

    let segment: UIView = {
      let _view = UIView()
      return _view
    }()

    let table: UITableView = {
      let tableView = UITableView()
        
      tableView.register(HomeListCell.self, forCellReuseIdentifier: HomeListCell.registerIdentifier)
      tableView.separatorStyle = .none
        
      return tableView
    }()

    override init(frame: CGRect) {
      super.init(frame: frame)

      setup()
    }
    
    func setup() {
      self.addSubview(self.headerViewContainer)

      headerViewContainer.addSubview(userImage)
      headerViewContainer.addSubview(username)
      headerViewContainer.addSubview(profileIndex)

      headerViewContainer.addSubview(vline)

      headerViewContainer.addSubview(hpIcon)
      headerViewContainer.addSubview(hpLabel)
      headerViewContainer.addSubview(hpValue)

      headerViewContainer.addSubview(primasLabel)
      headerViewContainer.addSubview(primasIcon)
      headerViewContainer.addSubview(pstValue)

      self.addSubview(self.table)
      self.addSubview(self.segment)

      setupLayout()
    }
    
    func setupLayout() {
        headerViewContainer.snp.makeConstraints {
          make in 
          make.top.left.right.equalTo(self)
          make.size.height.equalTo(265.0)
        }

        userImage.snp.makeConstraints {
          make in 
          make.top.equalTo(headerViewContainer).offset(50)
          make.centerX.equalTo(self)
          make.size.equalTo(CGSize(width: 60.0, height: 60.0))
        }

        username.snp.makeConstraints {
          make in 
          make.top.equalTo(userImage.snp.bottom).offset(MAIN_PADDING)
          make.centerX.equalTo(self)
        }
        
        profileIndex.snp.makeConstraints {
          make in 
          make.top.equalTo(username.snp.bottom).offset(8)
          make.centerX.equalTo(self)
        }

        vline.snp.makeConstraints {
          make in 
          make.top.equalTo(profileIndex.snp.bottom).offset(25)
          make.size.equalTo(CGSize(width: 0.5, height: 36.0))
          make.centerX.equalTo(self)
        }

        let width = SCREEN_WIDTH / 2
        let _left_group = UIView()
        let _right_group = UIView()

        _left_group.addSubview(hpLabel)
        _left_group.addSubview(hpIcon)
        _left_group.addSubview(hpValue)

        _right_group.addSubview(primasIcon)
        _right_group.addSubview(primasLabel)
        _right_group.addSubview(pstValue)
        

        headerViewContainer.addSubview(_left_group)
        headerViewContainer.addSubview(_right_group)
        
        _left_group.snp.makeConstraints {
          make in 
          make.top.equalTo(vline)
          make.left.equalTo(headerViewContainer)
          make.size.equalTo(CGSize(width: width, height: 38.0))
        }

        let x = hpLabel.intrinsicContentSize.width / 2.0 
        
        hpIcon.snp.makeConstraints {
          make in 
          make.top.equalTo(_left_group)
          make.size.equalTo(14)
          make.centerX.equalTo(_left_group).offset(-x - 2.5)
        }

        hpLabel.snp.makeConstraints {
          make in 
          make.top.equalTo(_left_group)
          make.left.equalTo(hpIcon.snp.right).offset(5)
        }

        _right_group.snp.makeConstraints {
          make in 
          make.top.equalTo(vline)
          make.right.equalTo(headerViewContainer)
          make.size.equalTo(CGSize(width: width, height: 36.0))
        }

        hpIcon.contentMode = .scaleToFill
        
        hpValue.snp.makeConstraints {
          make in 
          make.bottom.equalTo(_left_group)
          make.centerX.equalTo(_left_group)
        }

        pstValue.snp.makeConstraints {
          make in 
          make.bottom.equalTo(_right_group)
          make.centerX.equalTo(_right_group)
        }

        primasIcon.snp.makeConstraints {
          make in 
          make.top.equalTo(_right_group)
          make.centerX.equalTo(_right_group).offset(-primasLabel.intrinsicContentSize.width / 2 - 2.5)
        }

        primasLabel.snp.makeConstraints {
          make in 
          make.top.equalTo(_right_group)
          make.left.equalTo(primasIcon.snp.right).offset(5)
        }

        segment.snp.makeConstraints {
          make in 
          make.top.equalTo(headerViewContainer.snp.bottom)
          make.left.right.equalTo(self)
          make.size.height.equalTo(50)
        }

        setupSegment()

        table.snp.makeConstraints {
            make in
            make.top.equalTo(segment.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }

  func setupSegment() {
    let _view = segment
    let _left = UIView()
    let _right = UIView()
    
    let _left_label = UILabel()
    _left_label.text = "贡献内容 236"
    _left_label.font = primasFont(16)
    _left_label.textColor = PrimasColor.shared.main.red_font_color

    let _right_label = UILabel()
    _right_label.text = "我的社群 36"
    _right_label.font = primasFont(16)
    _right_label.textColor = PrimasColor.shared.main.gray_font_color

    _left.addSubview(_left_label)
    _right.addSubview(_right_label)

    let _line = ViewTool.generateLine(PrimasColor.shared.main.red_font_color, 1.0)
    _left.addSubview(_line)
    _view.addSubview(_right)
    _view.addSubview(_left)

    let _viewLine = ViewTool.generateLine()
    _view.addSubview(_viewLine)

    
    _viewLine.snp.makeConstraints {
      make in 
      make.left.right.bottom.equalTo(_view)
    }

    let width = (SCREEN_WIDTH - SIDE_MARGIN * 2) / 2

    _left.snp.makeConstraints {
      make in
      make.top.bottom.equalTo(_view)
      make.left.equalTo(_view).offset(SIDE_MARGIN)
      make.size.width.equalTo(width)
    }

    _line.snp.makeConstraints {
      make in 
      make.left.equalTo(_view).offset(SIDE_MARGIN)
      make.right.equalTo(_left.snp.right)
      make.bottom.equalTo(_view).offset(-1)
    }
    
    _right.snp.makeConstraints {
        make in
        make.top.bottom.equalTo(_view)
        make.right.equalTo(_view).offset(-SIDE_MARGIN)
        make.size.width.equalTo(width)
    }

    _left_label.snp.makeConstraints {
      make in 
      make.center.equalTo(_left)
    }

    _right_label.snp.makeConstraints {
      make in 
      make.center.equalTo(_right)
    }
  }
    
    func bind(_ profile: ProfileModel) {
      let url = URL(string: profile.userImageUrl)
      self.userImage.kf.setImage(with: url)
      username.text = profile.username
      profileIndex.text = " 个人指数 \(profile.profileIndex) "
      hpValue.text = "\(profile.hp)"
      pstValue.text = "\(profile.pst)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
