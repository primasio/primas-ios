import UIKit
import SnapKit
import Foundation

class TestSubViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  func setup() {
    let testView = TestView()
    testView.delegate = self
    self.view.addSubview(testView)
    
    self.view.backgroundColor = colorWith255RGBA(255, 255, 255, 0.7)
    
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
    
    func test() {
        print("testtttttttt")
    }

}
