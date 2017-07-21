//
//  ValueView.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class ValueView: UIView {
    var controler: ValueViewController?

    var headerViewTopConstraint: Constraint?
    
    let headerViewContainer: UIView = {
      let _view = UIView()
      _view.layer.contents = UIImage(named: "value-bg")?.cgImage
      return _view
    }()

    let yesterdayLabel: UILabel = {
      let _label = UILabel()
      _label.text = "昨日新增"
      _label.font = primasFont(14)
      _label.textAlignment = .center
      _label.textColor = UIColor.white

      return _label
    }()

    let yesterdayValue: UILabel = {
      let _label = UILabel()
      _label.textAlignment = .center
      _label.textColor = UIColor.white
      _label.font = primasNumberFont(36)
      return _label
    }()

    let myToken: UILabel = {
      let _label = UILabel()
      _label.textAlignment = .center
      _label.font = primasNumberFont(12)
      _label.textColor = PrimasColor.shared.main.light_white_font_color
      return _label
    }()

    let yesterdayToken: UILabel = {
      let _label = UILabel()
      _label.textAlignment = .center
      _label.font = primasNumberFont(12)
      _label.textColor = hexStringToUIColor("#ffb3b3")
      return _label
    }()

    let detail: UILabel = {
      let _label = UILabel()
      _label.text = "详情 >"
      _label.font = primasFont(12)
      _label.textColor = hexStringToUIColor("#ffb3b3")
      return _label
    }()

    let table: UITableView = {
      let _table = UITableView(frame: .zero, style: .grouped)
      _table.register(ValueTableViewCell.self, forCellReuseIdentifier: ValueTableViewCell.registerIdentifier)
      _table.separatorStyle = .none
      _table.backgroundColor = UIColor.white
      return _table
    }()

    let yesterdayTouchView = UIView()

    override init(frame: CGRect) {
      super.init(frame: frame)

      setup()
    }
    
    func setup() {
      self.addSubview(self.table)
      self.addSubview(self.headerViewContainer)
      self.headerViewContainer.addSubview(self.yesterdayLabel)
      self.headerViewContainer.addSubview(self.yesterdayValue)
      self.headerViewContainer.addSubview(self.myToken)
      self.headerViewContainer.addSubview(self.yesterdayToken)
      self.headerViewContainer.addSubview(self.detail)
      self.headerViewContainer.addSubview(self.yesterdayTouchView)

      setupLayout()
    }
    
    func setupLayout() {
        headerViewContainer.snp.makeConstraints {
          make in
            headerViewTopConstraint = make.top.equalTo(self).constraint
          make.left.right.equalTo(self)
          make.size.height.equalTo(230.0)
        }

        yesterdayLabel.snp.makeConstraints {
          make in 
          make.top.equalTo(headerViewContainer).offset(64)
          make.left.right.equalTo(headerViewContainer)
          make.centerX.equalTo(headerViewContainer)
          make.size.height.equalTo(12)
        }

        yesterdayValue.snp.makeConstraints {
          make in 
          make.left.right.equalTo(headerViewContainer)
          make.top.equalTo(yesterdayLabel.snp.bottom).offset(MAIN_PADDING)
          make.centerX.equalTo(yesterdayLabel)
          make.size.height.equalTo(36)

        }

        myToken.snp.makeConstraints {
          make in 
          make.left.right.equalTo(headerViewContainer)
          make.top.equalTo(yesterdayValue.snp.bottom).offset(25)
          make.centerX.equalTo(yesterdayLabel)
          make.size.height.equalTo(12)

        }

        let line = ViewTool.generateLine(hexStringToUIColor("#d53f2d"))
        headerViewContainer.addSubview(line)

        line.snp.makeConstraints {
          make in 
          make.left.right.equalTo(headerViewContainer)
          make.bottom.equalTo(headerViewContainer).offset(-40)
        }

        yesterdayToken.snp.makeConstraints {
          make in 
          make.left.equalTo(headerViewContainer).offset(SIDE_MARGIN)
          make.bottom.equalTo(headerViewContainer).offset(-SIDE_MARGIN)
        }

        detail.snp.makeConstraints {
          make in 
          make.right.equalTo(headerViewContainer).offset(-SIDE_MARGIN)
          make.bottom.equalTo(headerViewContainer).offset(-SIDE_MARGIN)
        }


        table.snp.makeConstraints {
            make in
            make.top.equalTo(headerViewContainer.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }

        yesterdayTouchView.snp.makeConstraints {
          make in 
          make.left.right.bottom.equalTo(headerViewContainer)
          make.top.equalTo(line.snp.top)
        }
    }
    
    func headerBind() {
      let token = (app().client.user?.balance) ?? 0
      let _value = (app().client.user?.amountYesterday) ?? 0
      let _yesterdayToken = (app().client.system?.pstYesterday) ?? 0
      
      let mytokenString = "我的Token总额 +\(String(describing: token)) PST"
      var attr = NSMutableAttributedString(string: mytokenString)
      attr.addAttributes([NSFontAttributeName: myToken.font], range: NSRange(location: 0, length: mytokenString.utf16.count - 3))
      attr.addAttributes([NSFontAttributeName: primasFont(8)], range: NSRange(location: mytokenString.utf16.count - 3, length: 3))
      myToken.attributedText = attr
        
      let yesterdayValueString = "+\(String(describing: _value)) PST"
      attr = NSMutableAttributedString(string: yesterdayValueString)
      attr.addAttributes([NSFontAttributeName: yesterdayValue.font], range: NSRange(location: 0, length: yesterdayValueString.utf16.count - 3))
      attr.addAttributes([NSFontAttributeName: primasFont(18)], range: NSRange(location: yesterdayValueString.utf16.count - 3, length: 3))
      yesterdayValue.attributedText = attr

      let yesterdayTokenString = "昨日Token发放数 \(String(describing: _yesterdayToken)) PST"
      attr = NSMutableAttributedString(string: yesterdayTokenString)
      attr.addAttributes([NSFontAttributeName: yesterdayToken.font], range: NSRange(location: 0, length: yesterdayTokenString.utf16.count - 3))
      attr.addAttributes([NSFontAttributeName: primasFont(8)], range: NSRange(location: yesterdayTokenString.utf16.count - 3, length: 3))
      yesterdayToken.attributedText = attr
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
