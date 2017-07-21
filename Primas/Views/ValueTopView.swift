//
//  ValueTopView.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class ValueTopView: UIView {
    
  var headerViewTopConstraint: Constraint?
    
  let headerViewContainer: UIView = {
    let _view = UIView()
    _view.backgroundColor = UIColor(patternImage: UIImage(named: "value-top-bg")!)
    _view.layer.contents = UIImage(named: "value-top-bg")?.cgImage
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
    _label.font = primasNumberFont(36)
    _label.textAlignment = .center
    _label.textColor = hexStringToUIColor("#ed5f4b")
    return _label
  }()

  let segment: SegmentView = {
      let _view = SegmentView(style: .single)
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

    segment.bind(leftTitle: "文章贡献榜", rightTitle: "圈子贡献榜")
    self.setupLayout()
  }

  func setupLayout() {

    headerViewContainer.snp.makeConstraints {
      make in
        headerViewTopConstraint = make.top.equalTo(self).constraint
      make.left.right.equalTo(self)
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
    
    table.snp.makeConstraints {
      make in 
      make.top.equalTo(segment.snp.bottom)
      make.left.right.bottom.equalTo(self)
    }

  }

  func headerBind() {
    let yesterdayValueString = "\(app().client.system?.pstYesterday ?? 0) PST"
    let attr = NSMutableAttributedString(string: yesterdayValueString)
      attr.addAttributes([NSFontAttributeName: yesterdayValue.font], range: NSRange(location: 0, length: yesterdayValueString.utf16.count - 3))
      attr.addAttributes([NSFontAttributeName: primasFont(18)], range: NSRange(location: yesterdayValueString.utf16.count - 3, length: 3))
      yesterdayValue.attributedText = attr
  }
    

}
