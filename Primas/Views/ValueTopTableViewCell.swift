//
//  ValueTopTableViewCell.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ValueTopTableViewCell: UITableViewCell {
    static let registerIdentifier = "ValueTopTableViewCell"
    static let rowHeight: CGFloat = 60.0

   
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
      _label.font = primasNumberFont(10)
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

    let shared: UILabel = {
      let _label = UILabel()
      _label.font = primasNumberFont(12)
      _label.textColor = PrimasColor.shared.main.sub_font_color
      return _label
    }()

    let praised: UILabel = {
      let _label = UILabel()
      _label.font = primasNumberFont(12)
      _label.textColor = PrimasColor.shared.main.sub_font_color
      return _label
    }()

    let transfered: UILabel = {
      let _label = UILabel()
      _label.font = primasNumberFont(12)
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

      self.viewContainer.addSubview(self.shared)
      self.viewContainer.addSubview(self.praised)
      self.viewContainer.addSubview(self.transfered)

      self.setupLayout()
    }

    func setupLayout() {
      viewContainer.snp.makeConstraints {
        make in 
        make.edges.equalTo(self).inset(UIEdgeInsetsMake(11, SIDE_MARGIN, 11, SIDE_MARGIN))
      }

      PST.snp.makeConstraints {
        make in 
        make.right.bottom.equalTo(viewContainer)
      }


      value.snp.makeConstraints {
        make in 
        make.right.equalTo(PST.snp.left)
        make.bottom.equalTo(viewContainer)
      }

      plus.snp.makeConstraints {
        make in 
        make.right.equalTo(value.snp.left)
        make.bottom.equalTo(viewContainer)
      }

      
      title.snp.makeConstraints {
        make in 
        make.left.top.equalTo(viewContainer)
        make.right.equalTo(viewContainer).offset(-100)
      }

      transfered.snp.makeConstraints {
        make in 
        make.left.bottom.equalTo(viewContainer)
      }

      shared.snp.makeConstraints {
        make in 
        make.left.equalTo(transfered.snp.right).offset(MAIN_PADDING)
        make.bottom.equalTo(viewContainer)
      }

      praised.snp.makeConstraints {
        make in 
        make.left.equalTo(shared.snp.right).offset(MAIN_PADDING)
        make.bottom.equalTo(viewContainer)
      }

      valueBadge.snp.makeConstraints {
        make in 
        make.right.equalTo(viewContainer)
        make.top.equalTo(viewContainer)
        make.size.equalTo(CGSize(width: 14, height: 14))
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

    func bind(_ ranking: SystemArticleRanking, _ index: Int) {
      let current = index + 1

      let article = app().client.getArticleById(ranking.articleId)

      self.value.text = "\(ranking.amount)"
      self.title.text = article?.title

      self.shared.text = (article?.statistics.share.toHumanString())! + "转发"
      self.praised.text = (article?.statistics.like.toHumanString())! + "赞"
      self.transfered.text = (article?.statistics.reproduction.toHumanString())! + "转载"

      var backgroundColor: UIColor = PrimasColor.shared.main.gray_font_color

      switch current {
        case 1:
          backgroundColor = hexStringToUIColor("#ff9933")
        case 2:
          backgroundColor = hexStringToUIColor("#33cc99")
        case 3:
          backgroundColor = hexStringToUIColor("#3399ff")
        default: 
          break
      }

      self.valueBadge.backgroundColor = backgroundColor
      self.valueBadge.text = "\(current)"
    }

}
