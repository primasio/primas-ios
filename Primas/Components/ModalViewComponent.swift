//
//  ModalViewComponent.swift
//  Primas
//
//  Created by wang on 16/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class ModalViewComponent: UIView {
  var cached: [UIView] = []
  var subView: UIView?
  var subviewHeight: CGFloat? 
  var isEventAdded: Bool = false
  var isShow: Bool = false
 
  init(subView: UIView, height: CGFloat) {
    super.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT ,width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    self.subView = subView
    self.subviewHeight = height
    setup()
  }
    
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func setup() {
    self.backgroundColor = colorWith255RGBA(0, 0, 0, 70)
    self.addSubview(subView!)

    subView?.snp.makeConstraints {
      make in
      make.left.right.equalTo(self)
      make.size.height.equalTo(subviewHeight!)
      make.bottom.equalTo(self)
    }

    addEvent()
  }

  func addEvent() {
    if !isEventAdded {
      let tap = UITapGestureRecognizer(target: self, action: #selector(hidden))
      tap.numberOfTapsRequired = 1
      self.isUserInteractionEnabled = true
      self.addGestureRecognizer(tap)

      isEventAdded = true
    }
  }

  func show() {
    if isShow {
      return 
    }

    isShow = true

    app().window?.bringSubview(toFront: self)
    self.frame.origin.y = 0
    UIView.animate(withDuration: 0.5, animations: {
      self.subView?.frame.origin.y = 0
    })
  }

  func hidden() {
    if !isShow {
      return 
    }

    UIView.animate(withDuration: 0.5, animations: {
      self.subView?.frame.origin.y = SCREEN_HEIGHT 
    }, completion: {
        done in
        if done {
            self.isShow = false
            self.frame.origin.y = SCREEN_HEIGHT 

        }
    })
  }

  func reload(subView: UIView, height: CGFloat) {
    if self.subView == subView {
      return 
    }

    if self.cached.contains(subView) {
      self.subView?.removeFromSuperview()
      self.subView = subView
      self.addSubview(subView)
      self.subviewHeight = height

      subView.snp.makeConstraints {
        make in
        make.left.right.equalTo(self)
        make.size.height.equalTo(subviewHeight!)
        make.bottom.equalTo(self)
      }
      self.subView?.frame.origin.y = SCREEN_HEIGHT
      
    } else {
      self.subView?.removeFromSuperview()
      self.subView = subView
      self.subviewHeight = height
      setup()
      self.subView?.frame.origin.y = SCREEN_HEIGHT
      self.cached.append(subView)
    }

  }
}
