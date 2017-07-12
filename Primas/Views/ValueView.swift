//
//  ValueView.swift
//  Primas
//
//  Created by wang on 12/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit

class ValueView: UIView {
    var controler: ValueViewController?

    let table: UITableView = {
      let _table = UITableView()
      // register cell
      return _table
    }()


    override init(frame: CGRect) {
      super.init(frame: frame)

      setup()
    }
    
    func setup() {
      self.addSubview(table)

      setupLayout()
    }
    
    func setupLayout() {
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
