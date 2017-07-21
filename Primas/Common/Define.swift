//
//  Define.swift
//  Primas
//
//  Created by wang on 09/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//
import UIKit
import SnapKit
import Foundation

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SIDE_MARGIN: CGFloat = 12.0
let MAIN_PADDING: CGFloat = 10.0

let CONTENT_WIDTH = SCREEN_WIDTH - SIDE_MARGIN * 2

enum ViewControllers {
  case home, group, value, valueTop, profile, pen, article
    func map() -> UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .value:
            return ValueViewController()
        case .valueTop:
          return ValueTopViewController()
        case .profile:
          return ProfileViewController()
        case .pen:
          return EditorViewController()
        case .group:
            return GroupViewController()
        case .article: 
            return ArticleDetailViewController()
        }
    }
}

func primasFont(_ fontSize: CGFloat, _ bold: Bool? = false) -> UIFont {
  if bold! {
    return UIFont.boldSystemFont(ofSize: fontSize)
  }
    
  return UIFont.systemFont(ofSize: fontSize)
}

func primasNumberFont(_ fontSize: CGFloat) -> UIFont {
  return UIFont(name: "Helvetica Neue", size: fontSize)!
}

func primasFontSpace(text: String, font: UIFont, _ space: CGFloat? = 6.0, _ zSpace: CGFloat? = 1.2) -> NSAttributedString {
  let style = NSMutableParagraphStyle()
  style.alignment = .left
  style.lineSpacing = space!
  style.hyphenationFactor = 1.0
  style.firstLineHeadIndent = 0.0
  style.paragraphSpacingBefore = 0.0
  style.headIndent = 0
  style.tailIndent = 0

  let dic = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style, NSKernAttributeName: zSpace!] as [String : Any]

  return NSAttributedString(string: text, attributes: dic)
}

// "yyyy-MM-dd"
func primasDate(_ format: String, _ time: Int) -> String {
  let date = Date(timeIntervalSince1970: TimeInterval(time))
  let formatter = DateFormatter()
  formatter.timeZone = TimeZone(abbreviation: "PRC")
  formatter.locale = NSLocale.current
  formatter.dateFormat = format

  return formatter.string(from: date)
}


func app() -> AppDelegate {
  return UIApplication.shared.delegate as! AppDelegate
}

func toController(_ type: ViewControllers, _ animated: Bool? = false) {
  var _controller = app().cachedViewControllers[type]
  if _controller == nil {
    app().cachedViewControllers[type] = type.map()
    _controller = app().cachedViewControllers[type]
  }

  if app().navigation.viewControllers.contains(_controller!) {
    app().navigation.popToViewController(_controller!, animated: animated!)
  } else {
    app().navigation.pushViewController(_controller!, animated: animated!)
  }
  
}

func popViewController() {
    if app().navigation.viewControllers.count != 0 {
        app().navigation.popViewController(animated: true)
    }
}




