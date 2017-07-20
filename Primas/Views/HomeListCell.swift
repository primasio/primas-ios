import UIKit
import SnapKit
import SwiftIconFont
import Kingfisher

class HomeListCell: UITableViewCell {
  static let registerIdentifier = "HomeListCell"
  let viewContainer: UIView = {
    let _view = UIView()
    _view.backgroundColor = UIColor.white
    return _view
  }()

  let groupImage: UIImageView = {
    let _view = UIImageView()
    _view.layer.masksToBounds = true
    _view.backgroundColor = UIColor.white
    _view.layer.cornerRadius = 14
    return _view
  }()

  let groupName: UILabel =  {
    let _label = UILabel()
    _label.font = primasFont(14)
    _label.textColor = PrimasColor.shared.main?.main_font_color
    return _label
  }()

  let groupSubtitle: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(11)
    _label.textColor = PrimasColor.shared.main.light_font_color
    return _label
  }()

  let banner: UIImageView = {
    let _view = UIImageView()
    _view.backgroundColor = PrimasColor.shared.main.main_background_color
    return _view
  }()

  let title: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(17)
    _label.textColor = PrimasColor.shared.main.main_font_color
    _label.numberOfLines = 2
    return _label
  }()

  let desc: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(14)
    _label.textColor = PrimasColor.shared.main.sub_font_color
    _label.numberOfLines = 2
    return _label
  }()

  let shared: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(13)
    _label.textColor = PrimasColor.shared.main.light_font_color
    return _label
  }()

  let transfered: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(13)
    _label.textColor = PrimasColor.shared.main.light_font_color
    return _label
  }()

  let date: UILabel = {
    let _label = UILabel()
    _label.font = primasFont(13)
    _label.textColor = PrimasColor.shared.main.gray_font_color
    return _label
  }()

  let cellLine: UIView = {
    let _view = UIView()
    _view.backgroundColor = PrimasColor.shared.main.light_background_color
    return _view
  }()

  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.selectionStyle = .none
    self.setup()
  }

  static var height:CGFloat = 375.0

  func setup() {
    self.contentView.addSubview(self.viewContainer)
    self.viewContainer.addSubview(self.groupImage)
    self.viewContainer.addSubview(self.groupName)
    self.viewContainer.addSubview(self.groupSubtitle)
    self.viewContainer.addSubview(self.banner)
    self.viewContainer.addSubview(self.title)
    self.viewContainer.addSubview(self.desc)
    self.viewContainer.addSubview(self.shared)
    self.viewContainer.addSubview(self.transfered)
    self.viewContainer.addSubview(self.date)
    self.viewContainer.addSubview(self.cellLine)

    self.setupLayout()
  }

  func setupLayout() {
    
    viewContainer.snp.makeConstraints({ make in
        make.edges.equalTo(self.contentView).inset(UIEdgeInsets(top: 0, left: 12, bottom: 17, right: 12))
    })

    groupImage.snp.makeConstraints {
      make in 
      make.left.equalTo(self.viewContainer)
      make.top.equalTo(self.viewContainer).offset(12)
      make.size.equalTo(CGSize(width: 28, height: 28))
    }

    groupName.snp.makeConstraints {
      make in 
      make.left.equalTo(groupImage.snp.right).offset(10)
      make.centerY.equalTo(groupImage)
    }

    groupSubtitle.snp.makeConstraints {
      make in 
      make.left.equalTo(groupName.snp.right).offset(10)
      make.centerY.equalTo(groupName)
    }

    banner.snp.makeConstraints {
      make in 
      make.left.right.equalTo(viewContainer)
      make.top.equalTo(groupImage.snp.bottom).offset(12)
      make.size.height.equalTo(SCREEN_WIDTH * 3 / 7)
    }

    title.snp.makeConstraints {
      make in 
      make.left.right.equalTo(viewContainer)
      make.top.equalTo(banner.snp.bottom).offset(12)
    }

    desc.snp.makeConstraints {
      make in 
      make.left.right.equalTo(viewContainer)
      make.top.equalTo(title.snp.bottom).offset(10)
    }

    shared.snp.makeConstraints {
      make in 
      make.left.equalTo(viewContainer)
      make.top.equalTo(desc.snp.bottom).offset(SIDE_MARGIN)
      make.bottom.equalTo(contentView.snp.bottom).offset(-20)
    }

    transfered.snp.makeConstraints {
      make in 
      make.left.equalTo(shared.snp.right).offset(10)
      make.top.equalTo(shared)
    }

    date.snp.makeConstraints {
      make in 
      make.right.equalTo(viewContainer)
      make.bottom.equalTo(transfered)
    }

    cellLine.snp.makeConstraints {
      make in 
      make.left.right.equalTo(contentView)
      make.bottom.equalTo(contentView)
      make.size.height.equalTo(10)
    }

  }

  func bind(_ model: CellModel) {
    let groupImageUrl = URL(string: model.groupImageUrl)
    if groupImageUrl != nil {
      groupImage.kf.setImage(with: groupImageUrl)
    }

    groupName.text = model.groupName
    groupSubtitle.text = "圈子"

    let bannerURL = URL(string: model.imageUrl)
    if bannerURL != nil {
      banner.kf.setImage(with: bannerURL)
    }
    
    let paragraphStyle = NSMutableParagraphStyle()
    //line height size
    paragraphStyle.lineSpacing = 4
    var attrString = NSMutableAttributedString(string: model.title)
    attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
    title.attributedText = attrString
    
    attrString = NSMutableAttributedString(string: model.description)
    attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

    desc.attributedText = attrString
    
    shared.text = model.shared.toHumanString() + " 转发"
    transfered.text = model.transfered.toHumanString() + " 转载"
    self.date.text = primasDate("MM-dd", model.date)
  }
}
