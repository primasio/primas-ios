import UIKit
import Foundation
import SnapKit

class ArticleDetailToolBar: ToolBar {
  enum ArticleDetailToolBarItemType: Int {
    case share = 1
    case transfer, praise, at 
  }

  let share: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.share.rawValue, "转发235")
    _bar.tag = ArticleDetailToolBarItemType.share.rawValue

    return _bar
  }()

  let transfer: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.transfer.rawValue, "转载 1.1k")
    _bar.tag = ArticleDetailToolBarItemType.transfer.rawValue

    return _bar
  }()

  let praise: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.praise_off.rawValue, "赞563")
    _bar.tag = ArticleDetailToolBarItemType.praise.rawValue

    return _bar
  }()

  let trend: UIBarButtonItem = {
    let _bar = ToolBar.makeButtonItem(Iconfont.trend.rawValue, "7日曲线")
    _bar.tag = ArticleDetailToolBarItemType.at.rawValue

    return _bar
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    let tap = UITapGestureRecognizer(target: self, action: #selector(praised))
    tap.numberOfTapsRequired = 1
    praise.customView?.isUserInteractionEnabled = true
    praise.customView?.addGestureRecognizer(tap)

    self.setItems([share, transfer, praise, trend], animated: false)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func getItems() -> Array<UIBarButtonItem> {
      if fixedItems.count != 0 {
        return fixedItems
      }

      let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
      let fixed = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: self, action: nil)
    
      fixed.width = -10
      var arr: Array<UIBarButtonItem> = [fixed, flexible]

      for  item in self.items! {
          arr.append(item)
        
          if item == trend  {
            arr.append(flexible)
            arr.append(fixed)
          } else {
            arr.append(flexible)
            arr.append(flexible)
          }
      }
        
      return arr
  }

  func bind(shared: Int, transfered: Int, praised: Int) {
    (self.share.customView?.subviews[1] as! UILabel).text = "转发" + shared.toHumanString()
    (self.transfer.customView?.subviews[1] as! UILabel).text = "转载" + transfered.toHumanString()
    (self.praise.customView?.subviews[1] as! UILabel).text = "赞" + praised.toHumanString()
  }

  func praised() {
    let _icon = self.praise.customView?.subviews[0] as! UILabel
    _icon.text = Iconfont.praise_on.rawValue
    _icon.textColor = PrimasColor.shared.main.red_font_color
    
    let _title = self.praise.customView?.subviews[1] as! UILabel
    _title.textColor = PrimasColor.shared.main.red_font_color
  }
}
