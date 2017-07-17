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

  static func generateNavigationBarItem(_ code: Iconfont, _ color: UIColor? = UIColor.white, _ target: Any? = nil, _ action: Selector? = nil) -> UIBarButtonItem {
    let _item = UIBarButtonItem(title: code.rawValue, style: .plain, target: target, action: action)
    _item.setTitleTextAttributes([NSFontAttributeName: UIFont.iconfont(ofSize: 22.0)!, NSForegroundColorAttributeName: color!], for: .normal)
    return _item
  }

  static func generateDashLine(width: CGFloat, height: CGFloat, _ color: UIColor? = PrimasColor.shared.main.line_background_color, _ dashLength: Float? = 3.0, _ dashSpacing: Float? = 3.0) -> UIView {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
    let shape = CAShapeLayer()

    shape.frame = view.frame
    shape.fillColor = UIColor.clear.cgColor
    shape.strokeColor = color!.cgColor
    shape.lineWidth = height
    shape.lineJoin = kCALineJoinRound
    shape.lineDashPattern = [NSNumber(value: dashLength!), NSNumber(value: dashSpacing!)]

    let path = CGMutablePath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: width, y: height))
    shape.path = path
    
    view.layer.addSublayer(shape)
    return view
  }
}
