//
//  TestView.swift
//  Primas
//
//  Created by wang on 06/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit
import Foundation

class TestView: UIView {
  let viewContainer: UIView = UIView()
  var delegate: UIViewController?
  let testLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.red
    viewContainer.backgroundColor = UIColor.white

    addSubview(viewContainer)
    addSubview(testLabel)

    viewContainer.snp.makeConstraints {
      make in 
      make.left.right.top.equalTo(self)
      make.size.equalTo(CGSize(width: 200, height: 200))
    }

    testLabel.text = "Test, Tap Me"
    testLabel.snp.makeConstraints {
      make in 
      make.center.equalTo(viewContainer)
    }
  }
     
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
}
