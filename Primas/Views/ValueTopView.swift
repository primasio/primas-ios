//
//  ValueTopView.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ValueTopView: UIView {
  let headerViewContainer: UIView = {
    let _view = UIView()
    _view.backgroundColor = UIColor(patternImage: UIImage(named: "value-top-bg")!)
    return _view
  }()

  let yesterdayLabel: UILabel = {
    let _label = UILabel()
    _label.text = "昨日Token发放数"
    _label.font = primasFont(12)
    _label.textAlignment = .center
    _label.textColor = hexStringToUIColor("#ed5f4b")
    return _label
  }()

  let yesterdayValue: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(36)
    _label.textAlignment = .center
    _label.textColor = hexStringToUIColor("#ed5f4b")
    return _label
  }()

  let segment: UIView = {
    let _view = UIView()
    return _view
  }()

  let table:UITableView = {
    let _table = UITableView()
    _table.register(ValueTopTableViewCell.self, forCellReuseIdentifier: ValueTopTableViewCell.registerIdentifier)
    _table.separatorStyle = .none
    return _table
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.setup()
  }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

  func setup() {
    self.addSubview(headerViewContainer)
    headerViewContainer.addSubview(yesterdayLabel)
    headerViewContainer.addSubview(yesterdayValue)
    self.addSubview(segment)
    self.addSubview(table)

    self.setupLayout()
  }

  func setupLayout() {

    headerViewContainer.snp.makeConstraints {
      make in 
      make.left.right.top.equalTo(self)
      make.size.height.equalTo(150)
    }
    
    yesterdayLabel.snp.makeConstraints {
      make in 
      make.left.right.equalTo(headerViewContainer)
      make.top.equalTo(headerViewContainer).offset(58)
    }

    yesterdayValue.snp.makeConstraints {
      make in 
      make.left.right.equalTo(headerViewContainer)
      make.top.equalTo(yesterdayLabel).offset(14)
    }

    segment.snp.makeConstraints {
      make in 
      make.left.right.equalTo(self)
      make.top.equalTo(headerViewContainer.snp.bottom)
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
    _left_label.text = "文章贡献榜"
    _left_label.font = primasFont(16)
    _left_label.textColor = PrimasColor.shared.main.red_font_color

    let _right_label = UILabel()
    _right_label.text = "圈子贡献榜"
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


  func headerBind() {
     yesterdayValue.text = "36541.23"
  }

}
