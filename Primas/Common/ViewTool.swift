import UIKit
import SnapKit
import Foundation

class ViewTool {
  static func generateLine(_ background: UIColor? = PrimasColor.shared.main.content_line_background_color, _ height: CGFloat? = 0.5) -> UIView {
    let _view = UIView()
    _view.backgroundColor = background!
    _view.snp.makeConstraints {
      make in
      make.size.height.equalTo(height!)
    }
    return _view
  }

  static func generateIcon(_ code: Iconfont, _ size: CGFloat? = 12.0, _ color: UIColor? = UIColor.white ) -> UILabel {
    let _label = UILabel()
    _label.text = code.rawValue
    _label.font = UIFont.iconfont(ofSize: size!)
    _label.textColor = color!

    return _label
  }

  static func generateLabel(_ text:String? = "", _ size: CGFloat? = 12.0, _ color: UIColor? = UIColor.white) -> UILabel {
    let _label = UILabel()
    _label.text = text
    _label.font = primasFont(size!)
    _label.textColor = color!
    return _label
  }

  static func generateNavigationBarItem(_ code: Iconfont, _ color: UIColor? = UIColor.white) -> UIBarButtonItem {
    let _item = UIBarButtonItem(title: code.rawValue, style: .plain, target: nil, action: nil)
    _item.setTitleTextAttributes([NSFontAttributeName: UIFont.iconfont(ofSize: 22.0)!, NSForegroundColorAttributeName: color!], for: .normal)
    return _item
  }
}
