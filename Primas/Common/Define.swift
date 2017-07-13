//
//  Define.swift
//  Primas
//
//  Created by wang on 09/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//
import UIKit
import Foundation

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SIDE_MARGIN: CGFloat = 12.0
let MAIN_PADDING: CGFloat = 10.0

func primasFont(_ fontSize: CGFloat, _ bold: Bool? = false) -> UIFont {
  if bold! {
    return UIFont.boldSystemFont(ofSize: fontSize)
  }
    
  return UIFont.systemFont(ofSize: fontSize)
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

func toController(_ controller: UIViewController) {
  app().navigation.pushViewController(controller, animated: true)
}
