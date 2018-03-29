//
//  PostStepOne.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/20.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import RSKGrowingTextView
import BonMot

class PostStepOne: BaseViewController {
    @IBOutlet weak var titleText: RSKGrowingTextView!
    @IBOutlet weak var contentText: RSKPlaceholderTextView!
    @IBOutlet weak var keyBoardBtn: UIButton!
    @IBOutlet weak var photoLibBtn: UIButton!
    @IBOutlet weak var caremaBtn: UIButton!
    @IBOutlet weak var textBootom: NSLayoutConstraint!
    @IBOutlet weak var toolBarView: UIView!
    fileprivate var toolBar: EditToolBar?
    
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let TITLE_FONT_SIZE:CGFloat = 19
        let CONTENT_FONT_SIZE:CGFloat = 16

        // configuer nav
        
        let leftBaritem = UIBarButtonItem.init(
            title: Rstring.common_Cancel.localized(),
            style: .plain,
            target: self,
            action: #selector(dissMiss))
        let rightButton = UIBarButtonItem.init(
            title: Rstring.common_Nextstep.localized(),
            style: .plain,
            target: self,
            action: #selector(nextStep))

        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.leftBarButtonItem = leftBaritem
        self.navigationItem.title = Rstring.common_edit.localized()
        
        // textView
        let style = StringStyle(
            .font(UIFont.boldSystemFont(ofSize: TITLE_FONT_SIZE)),
            .color(Rcolor.cccccC()))
        titleText.font = UIFont.boldSystemFont(ofSize: TITLE_FONT_SIZE)
        titleText.attributedPlaceholder = Rstring.post_title_place.localized().styled(with: style)
        titleText.maximumNumberOfLines = 2
        titleText.delegate = self
        contentText.font = UIFont.systemFont(ofSize: CONTENT_FONT_SIZE)
        contentText.placeholder = Rstring.post_content_place.localized() as NSString
        contentText.placeholderColor = Rcolor.cccccC()
        contentText.delegate = self
        
        // Notification
        X_Notification.addObserver(
            self,
            selector: #selector(PostStepOne.keyboardShow),
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil)
        X_Notification.addObserver(
            self,
            selector: #selector(PostStepOne.keyboardDiss),
            name: NSNotification.Name.UIKeyboardDidHide,
            object: nil)
        X_Notification.addObserver(
            self, selector: #selector(dissMiss),
            name: GET_Notification_Name(.end_post_article),
            object: nil)
        
        // tool bar
        toolBar = Rnib.editToolBar.firstView(owner: nil)
        toolBar?.frame = CGRect.init(x: 0, y: 0, width: kScreenW, height: 35)
        titleText.inputAccessoryView = toolBar
        contentText.inputAccessoryView = toolBar
        toolBar?.endEditBlock = {  self.baseEdit() }
        toolBar?.selelctPhoto = { self.openPhotoLibrary() }
        toolBar?.openCarema = { self.openCamera() }
        
        autoPresentNoPST(usePst: POST_ARTICLE_PST, disPlay: .post_content)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PostArticle.shared.tags.removeAll()
    }
    
    @objc func dissMiss()  {
        baseEdit()
        PostArticle.shared.resetDat()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - next step action
    @objc func nextStep() {
        baseEdit()
        let title = titleText.text
        let content = contentText.text
        guard !(title?.isEmpty)! else {
            self.hudShow(Rstring.post_no_title.localized())
            return
        }
        guard !(content?.isEmpty)! else {
            self.hudShow(Rstring.post_no_content.localized())
            return
        }
        enoughBalance(usePst: POST_ARTICLE_PST) { (flag) in
            if flag {
                self.nextStepAction()
            } else {
                self.presentNoPST(disPlay: .post_content)
            }
        }        
    }

    func nextStepAction()  {
        let title = titleText.text
        let content = contentText.text
        // record data
        PostArticle.shared.title = title!
        PostArticle.shared.content = content!
        
        let vc = Rstoryboard.postPage.postStepTwo()
        pushVc(vc!)
    }
    
    @objc func keyboardShow(notification: NSNotification)  {
            toolBarView.isHidden = true
            toolBar?.isHidden = false
        if let infoKey  = notification.userInfo?[UIKeyboardFrameEndUserInfoKey],
            let rawFrame = (infoKey as AnyObject).cgRectValue {
            let keyboardFrame = view.convert(rawFrame, from: nil)
            var heightKeyboard = keyboardFrame.size.height
            if IS_iPhoneX {
                heightKeyboard = heightKeyboard - CGFloat.init(IPHONEX_BOTTOM)
            }
            self.textBootom.constant = heightKeyboard
        }
    }
    
    @objc func keyboardDiss(notify: Notification)  {
            toolBarView.isHidden = false
            toolBar?.isHidden = true
            self.textBootom.constant = 0
    }
    
    func baseEdit()  {
        keyBoardBtn.isSelected = false
        self.view.endEditing(true)
    }
    
    // open PhotoLibrary
    func openPhotoLibrary()  {
        PohtoManage.shared.choosePicture(
            self,
            editor: true,
            options: .photoLibrary) { (image) in
                self.insertPicture(image)
        }
    }
    // open camera
    func openCamera()  {
        PohtoManage.shared.choosePicture(
            self,
            editor: true,
            options: .camera) { (image) in
                self.insertPicture(image)
        }
    }
    
    // Insert photo
    func insertPicture(_ image:UIImage){
        
        let textView = contentText!
        // 获取textView的所有文本，转成可变的文本
        let mutableStr = NSMutableAttributedString(attributedString: textView.attributedText)
        // 创建图片附件
        let imgAttachment = NSTextAttachment(data: nil, ofType: nil)
        var imgAttachmentString: NSAttributedString
        imgAttachment.image = self.compressImage(image: image)
        // 撑满一行
        let imageWidth = textView.frame.width - 10
        let imageHeight = image.size.height / image.size.width * imageWidth
        let imageMargin:CGFloat = 15
        imgAttachment.bounds = CGRect(x: 0,
                                          y: imageMargin,
                                          width: imageWidth,
                                          height: imageHeight)
        
        imgAttachmentString = NSAttributedString(attachment: imgAttachment)
        
        // 获得目前光标的位置
        let selectedRange = textView.selectedRange
        // 插入文字
        mutableStr.insert(imgAttachmentString, at: selectedRange.location)
        // 设置可变文本的字体属性
        mutableStr.addAttribute(
            NSAttributedStringKey.font,
            value: UIFont.systemFont(ofSize: 19),
            range: NSMakeRange(0,mutableStr.length))
        // 再次记住新的光标的位置
        let newSelectedRange = NSMakeRange(selectedRange.location + 1, 0)
        // 重新给文本赋值
        contentText.isEditable = false
        textView.attributedText = mutableStr
        contentText.isEditable = true
        // 恢复光标的位置（上面一句代码执行之后，光标会移到最后面）
        textView.selectedRange = newSelectedRange
        // 移动滚动条（确保光标在可视区域内）
        textView.scrollRangeToVisible(newSelectedRange)
    }
    
    func compressImage(image: UIImage) -> UIImage {
        let data = UIImageJPEGRepresentation(image, 0.3)
        let resultImage = UIImage.init(data: data!)
        return resultImage!
    }
    
    // MARK: - outlet action
    @IBAction func keyBoardAction(_ sender: Any) {
        contentText.becomeFirstResponder()
    }
    @IBAction func photoLibAction(_ sender: Any) {
        openPhotoLibrary()
    }
    @IBAction func caremaAction(_ sender: Any) {
        openCamera()
    }

    func testNoPst()  {
        Utility.delay(2) {
            let vc = Rstoryboard.noticeView.noMoneyPage()!
            vc.modalPresentationStyle = .overCurrentContext
            self.presentVc(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UITextViewDelegate
extension PostStepOne: UITextViewDelegate {

    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if textView == titleText && text == "\n" {
            titleText.resignFirstResponder()
            contentText.becomeFirstResponder()
            return false
        }
        return true
    }

}
