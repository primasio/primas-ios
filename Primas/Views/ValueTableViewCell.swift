//
//  ValueTableViewCell.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class ValueTableViewCell: UITableViewCell {
    static let registerIdentifier = "ValueTableViewCell"
    static let rowHeight: CGFloat = 60.0

    static func generateSection(_ date: String) -> UIView {
      let _view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 35))
      _view.backgroundColor = hexStringToUIColor("#efefef")
      let _label = UILabel()
      _label.text = date
      _label.font = primasFont(12)
      _label.textColor = PrimasColor.shared.main.sub_font_color
      _view.addSubview(_label)
      return _view
    }

    let viewContainer: UIView = {
      let _view = UIView()
      _view.backgroundColor = UIColor.white
      return _view
    }()

    let plus: UILabel = {
      let _label = UILabel()
      _label.text = "+"
      _label.font = primasFont(11)
      _label.textColor = PrimasColor.shared.main.red_font_color
      return _label
    }()

    let PST: UILabel = {
      let _label = UILabel()
      _label.text = "PST"
      _label.font = primasFont(11)
      _label.textColor = PrimasColor.shared.main.red_font_color
      return _label
    }()

    let value: UILabel = {
      let _label = UILabel()
      _label.font = primasNumberFont(15)
      _label.textColor = PrimasColor.shared.main.red_font_color 
      return _label
    }()

    let valueBadge: UILabel = {
      let _label = UILabel()
      _label.font = primasFont(10)
      _label.textColor = UIColor.white
      _label.textAlignment = .center
      return _label
    }()

    let title: UILabel = {
      let _label = UILabel()
      _label.font = primasFont(15)
      _label.textColor = PrimasColor.shared.main.main_font_color
      return _label
    }()

    let createdAt: UILabel = {
      let _label = UILabel()
      _label.font = primasFont(12)
      _label.textColor = PrimasColor.shared.main.sub_font_color
      return _label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      self.selectionStyle = .none
      self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

    func setup() {
      self.contentView.addSubview(self.viewContainer)
      self.viewContainer.addSubview(self.plus)
      self.viewContainer.addSubview(self.PST)
      self.viewContainer.addSubview(self.value)
      self.viewContainer.addSubview(self.valueBadge)
      self.viewContainer.addSubview(self.title)
      self.viewContainer.addSubview(self.createdAt)

      self.setupLayout()
    }

    func setupLayout() {
      viewContainer.snp.makeConstraints {
        make in 
        make.edges.equalTo(self).inset(UIEdgeInsetsMake(11, SIDE_MARGIN, 11, SIDE_MARGIN))
      }

      plus.snp.makeConstraints {
        make in 
        make.left.equalTo(viewContainer)
      }

      value.snp.makeConstraints {
        make in 
        make.left.equalTo(plus.snp.right)
        make.top.equalTo(viewContainer)
      }

      plus.snp.makeConstraints {
        make in 
        make.bottom.equalTo(value.snp.bottom)
      }

      PST.snp.makeConstraints {
        make in 
        make.left.equalTo(value.snp.right)
        make.bottom.equalTo(value)
      }

      title.snp.makeConstraints {
        make in 
        make.left.equalTo(viewContainer).offset(90)
        make.right.top.equalTo(viewContainer)
      }

      createdAt.snp.makeConstraints {
        make in 
        make.left.equalTo(title)
        make.bottom.equalTo(viewContainer)
      }

      valueBadge.snp.makeConstraints {
        make in 
        make.left.equalTo(viewContainer)
        make.bottom.equalTo(viewContainer)
        make.size.equalTo(CGSize(width: 23, height: 13))
      }

      let line = ViewTool.generateLine()
      self.addSubview(line)

      line.snp.makeConstraints {
        make in 
        make.left.right.equalTo(viewContainer)
        make.bottom.equalTo(contentView)
      }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ value: ValueModel) {
      self.value.text = "\(value.award)"
      self.title.text = value.title
      self.createdAt.text = primasDate("yyyy-MM-dd", value.createdAt)
      self.valueBadge.backgroundColor = getPrimasAwardBackgroundColor(value.awardType)
      self.valueBadge.text = PrimasAwardTypeDictionary[value.awardType]
    }
}
