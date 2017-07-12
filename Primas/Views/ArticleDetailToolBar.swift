import UIKit
import Foundation
import SnapKit

class ArticleDetailToolBar: ToolBar {
  enum ArticleDetailToolBarItemType: Int {
    case share = 1
    case rights, good, at 
  }

  let share: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.share.rawValue, "转发235")
    _bar.tag = ArticleDetailToolBarItemType.share.rawValue

    return _bar
  }()

  let rights: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.rights.rawValue, "转载 1.1k")
    _bar.tag = ArticleDetailToolBarItemType.rights.rawValue

    return _bar
  }()

  let good: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.good.rawValue, "赞563")
    _bar.tag = ArticleDetailToolBarItemType.good.rawValue

    return _bar
  }()

  let at: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.at.rawValue, "7日曲线")
    _bar.tag = ArticleDetailToolBarItemType.at.rawValue

    return _bar
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let title = popular.customView!.subviews[0] as! UILabel
    title.textColor = UIColor.red

    self.setItems([share, rights, good, at], animated: false)
  }
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

}
