import UIKit
import SnapKit
import Foundation

class TestSubViewController: UIViewController {
  var testView: TestView = TestView()
    
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    
    testView.delegate = self

    self.view.addSubview(testView)
    
    self.view.backgroundColor = colorWith255RGBA(0, 0, 0, 100)
    
    self.view.snp.makeConstraints {
        make in
        make.size.equalTo(CGSize(width: 400, height: 400))
        make.center.equalTo(self.view)

    }
    
    testView.snp.makeConstraints {
      make in 
      make.left.top.equalTo(self.view).offset(10)
      make.right.bottom.equalTo(self.view).offset(-10)
    }
  }
    

}
