import UIKit

func colorWith255RGB(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
  return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 255)
}

func colorWith255RGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
  return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a/255.0)
}

func hexStringToUIColor (_ hex:String, alpha: CGFloat? = 1.0) -> UIColor {
  var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

  if (cString.hasPrefix("#")) {
      cString.remove(at: cString.startIndex)
  }

  if ((cString.characters.count) != 6) {
      return UIColor.gray
  }

  var rgbValue:UInt32 = 0
  Scanner(string: cString).scanHexInt32(&rgbValue)

  return UIColor(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(alpha!)
  )
}

protocol PrimasColorProtocol {
  var main_font_color: UIColor { get }
  var sub_font_color: UIColor { get }
  var light_font_color: UIColor { get }
  var light_white_font_color: UIColor {get}
  var gray_font_color: UIColor {get}
  var main_background_color: UIColor {get}
  var light_background_color: UIColor {get}
  var line_background_color: UIColor {get}
  var content_line_background_color: UIColor {get}
  var home_tool_bar_item_color: UIColor {get}
  var home_tool_bar_item_active_color: UIColor {get}
  var home_tool_bar_item_active_background_color: UIColor {get}
  var red_font_color: UIColor {get}

  var infringement_background_color: UIColor {get}
}

class PrimasColor {
  var main: PrimasColorProtocol!
  static var shared: PrimasColor = PrimasColor(main: PrimasDefaultColor())

  init(main: PrimasColorProtocol) {
    self.main = main 
  }
}


class PrimasDefaultColor: PrimasColorProtocol {
  var main_font_color: UIColor {
    get {
      return hexStringToUIColor("#333333")
    }
  }
    
  var sub_font_color: UIColor {
      get {
          return hexStringToUIColor("#666666")
      }
  }

  var light_font_color: UIColor {
    get {
      return hexStringToUIColor("#999999")
    }
  }

  var gray_font_color: UIColor {
    get {
      return hexStringToUIColor("#cccccc")
    }
  }

  var main_background_color: UIColor {
    get {
      return colorWith255RGB(255, 255, 255)
    }
  }

  var light_background_color: UIColor {
    get {
      return colorWith255RGB(237, 238, 243)
    }
  }

  var line_background_color: UIColor {
    get {
      return colorWith255RGB(204, 204, 204)
    }
  }

  var content_line_background_color: UIColor {
    get {
      return hexStringToUIColor("#dddddd")
    }
  }

  var home_tool_bar_item_color: UIColor {
    get {
      return hexStringToUIColor("#333333")
    }
  }
  
  var home_tool_bar_item_active_color: UIColor {
    get {
      return colorWith255RGB(255, 255, 255)
    }
  }

  var home_tool_bar_item_active_background_color: UIColor {
    get {
      return hexStringToUIColor("#d8412e")
    }
  }

  var red_font_color: UIColor {
    get {
      return hexStringToUIColor("#d8412e")
    }
  }

  var infringement_background_color: UIColor {
    get {
      return hexStringToUIColor("#f9f7f7")
    }
  }

  var light_white_font_color: UIColor {
    get {
      return hexStringToUIColor("#ffcccc")
    }
  }
}

