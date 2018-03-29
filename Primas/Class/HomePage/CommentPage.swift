//
//  CommentPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/25.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import EmptyKit

class CommentPage: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var viewBottom: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    
    var dna: String = ""
    var GroupDNA: String = ""
    fileprivate var tempStart = ""
    fileprivate var tempOffset = request_start_offset
    fileprivate var datas: [CommentModel] = []
    

    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = Color_F7F7F7
        tableView.register(Rnib.commentCell)
        tableView.delegate = self
        tableView.dataSource = self
        textView.setCornerRadius(radius: 16)
        textFiled.delegate = self
        tableView.ept.dataSource = self
        KeyboardManager.enAbleToolBar()
        
        // Notification
        X_Notification.addObserver(
            self,
            selector: #selector(CommentPage.keyboardShow),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil)
        X_Notification.addObserver(
            self,
            selector: #selector(CommentPage.keyboardDiss),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
        
        tableView.initMJHeader {
            self.refresh()
        }
        tableView.initMJFooter {
            self.getComment(start: self.tempStart, offset: self.tempOffset)
        }

        tempStart = Utility.currentTimeStamp()
        getComment(start: tempStart, offset: tempOffset)
        
     }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if textFiled.isFirstResponder {
            textFiled.resignFirstResponder()
        }
    }
    
    func refresh()  {
        self.tempStart = Utility.currentTimeStamp()
        self.tempOffset = request_start_offset
        self.tableView.resetNoMoreData()
        self.getComment(start: self.tempStart, offset: self.tempOffset)
    }
    
    @objc func keyboardShow(notify: Notification)  {
        guard textFiled.isFirstResponder else { return }
        if let infoKey  = notify.userInfo?[UIKeyboardFrameEndUserInfoKey],
            let rawFrame = (infoKey as AnyObject).cgRectValue {
            let keyboardFrame = view.convert(rawFrame, from: nil)
            var heightKeyboard = keyboardFrame.size.height
            if IS_iPhoneX {
                heightKeyboard = heightKeyboard - CGFloat.init(IPHONEX_BOTTOM)
            }
            self.bottomView.transform = CGAffineTransform.init(translationX: 0, y: -heightKeyboard)
        }
    }

    @objc func keyboardDiss(notify: Notification)  {
        guard textFiled.isFirstResponder else { return }
        self.bottomView.transform = CGAffineTransform.identity
    }
    
    @IBAction func commentAction(_ sender: Any) {
        comment() 
    }
    
    // MARK: - Network
    func getComment(start: String, offset: Int)  {
        ArticleAPI.getComment(
            dna: dna,
            Start: start,
            Offset: offset,
            suc: { models in
                if offset == request_start_offset {
                    self.datas.removeAll()
                }
                for model in models {
                    self.datas.append(model)
                }
                self.navigationItem.title = Rstring.common_comment.localized() + "(" + "\(models.count)" + ")"
                self.tableView.endMJRefresh()
                self.tempOffset += models.count
                if models.count < articles_page_size {
                    self.tableView.noMoreData()
                }
                self.tableView.reloadData()
                if self.datas.isEmpty {
                    self.tableView.backgroundColor = Color_F7F7F7
                } else {
                    self.tableView.backgroundColor = UIColor.white
                }
         }) { (error) in
            self.hudShow(error.localizedDescription)
            self.tableView.endMJRefresh()
            debugPrint(error)
        }
    }
    
    func comment()  {
        let content = textFiled.text
        guard !dna.isEmpty else {  return }
        guard !GroupDNA.isEmpty else {  return }
        guard !(content?.isEmpty)! else {
            hudShow(Rstring.notice_empty_comment.localized())
            return
        }
        let vc = Rstoryboard.noticeView.postPwdNotice()!
        vc.display = .useHp
        vc.pwdBlock = {  (pwd) in
            
            ArticleAPI.comment(
                passphrase: pwd,
                dna: self.dna,
                GroupDNA: self.GroupDNA,
                Content: content!,
                suc: {
                    self.hudShow(Rstring.notice_comment_success.localized())
                    self.refresh()
                    self.textFiled.text = ""
            }) { (error) in
                if IS_PwdError(error) {
                    Utility.delay(0.5, closure: {
                        self.pwdErrorAlert {  self.comment() }
                    })
                } else {
                    self.hudShow(error.localizedDescription)
                }
                debugPrint(error.localizedDescription)
            }
        }
        vc.modalPresentationStyle = .overCurrentContext
        presentVc(vc, animated: false)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CommentPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CommentCell = tableView.dequeueReusableCell(withIdentifier: RreuseIdentifier.commentCell, for: indexPath)!
        if !self.datas.isEmpty {
            cell.setData(datas[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.datas.isEmpty {
            return CommentCell.cellHeight(datas[indexPath.row])
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CommentPage: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        comment()
        return true
    }
}
// MARK: - EmptyDataSource
extension CommentPage: EmptyDataSource {
    
    func titleForEmpty(in view: UIView) -> NSAttributedString? {
        return Utility.emptyAttributed(Rstring.common_no_comment.localized())
    }
    
    func imageForEmpty(in view: UIView) -> UIImage? {
        return Rimage.zanwupinglun1()
    }
    
    func backgroundColorForEmpty(in view: UIView) -> UIColor {
        return Color_F7F7F7
    }
}

extension CommentPage: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if textFiled.isEditing {
            textFiled.resignFirstResponder()
        }
    }
}

