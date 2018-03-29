
//  MnemonicsPage.swift
//  TokenUp
//
//  Created by xuxiwen on 2017/12/11.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit
import ethers
import BonMot
import RSKGrowingTextView
import MBProgressHUD

public enum IMPORT_TYPE {
    case keystore
    case mnemonic
    case register
}

class ImportPage:
    UIViewController,
    UITextViewDelegate,
    UITextFieldDelegate {
    
    // first view
    @IBOutlet weak var backScollview: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var contextText: RSKGrowingTextView!
    @IBOutlet weak var blueLine1: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var checkImg: UIImageView!
    @IBOutlet weak var firstLimit: UILabel!

    // second view
    @IBOutlet weak var setPwdTitle: UILabel!
    @IBOutlet weak var setPwdText: UITextField!
    @IBOutlet weak var pwdLevelImg: UIImageView!
    @IBOutlet weak var pwdLevel: UILabel!
    @IBOutlet weak var blueLine2: UIView!
    @IBOutlet weak var pwdLimit: UILabel!
    
    // threee view
    @IBOutlet weak var repeatPwdTitle: UILabel!
    @IBOutlet weak var repeatText: UITextField!
    @IBOutlet weak var checkImg2: UIImageView!
    @IBOutlet weak var blueLine3: UIView!
    @IBOutlet weak var thirdLimit: UILabel!
    
    fileprivate var loading = false
    
    // enumenum
    enum IMPORT_STEP {
        case import_one
        case import_two
        case import_three
    }
    
    open var disPlayType:IMPORT_TYPE = .keystore
    fileprivate var import_Step:IMPORT_STEP = .import_one
    fileprivate lazy var activity: UIActivityIndicatorView = {
        return UIActivityIndicatorView.init(activityIndicatorStyle: .white)
    }()
    
    
    // MARK: - Lift circle
    deinit {
        X_Notification.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nav
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(
            image: Rimage.back()!.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(popAction))
        
        // lisntening Text input
        X_Notification.addObserver(
            self, selector: #selector(contentText),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: nil)
        setPwdText.addTarget(
            self,
            action: #selector(pwdEditing),
            for: .editingChanged)
        repeatText.addTarget(
            self,
            action: #selector(pwd2Editing),
            for: .editingChanged)
        
        let common_style = StringStyle(
            .font(UIFont.systemFont(ofSize: 15)),
            .color(Rcolor.c666666()),
            .lineSpacing(5))

        switch disPlayType {
        case .keystore:
            titleLabel.text = Rstring.import_KEYSTORE.localized()
            contentLabel.attributedText = Rstring.keystore_SUB_CONTENT.localized()
                .styled(with: common_style)
            subTitle.text = Rstring.keystore_TEXT.localized()
            contextText.placeholder = Rstring.keystore_TEXT.localized() as NSString
            nextBtn.setTitle(Rstring.common_Nextstep.localized(), for: .normal)
            setPwdTitle.text = Rstring.setting_PWD.localized()
            setPwdText.placeholder = Rstring.setting_PWD.localized()
            pwdLimit.isHidden = true
            pwdLevelImg.isHidden = true
            pwdLevel.isHidden = true
            setPwdText.returnKeyType = .done
            contextText.maximumNumberOfLines = 2
            firstLimit.isHidden = true
            break
        case .mnemonic:
            titleLabel.text = Rstring.import_MNEMONIC.localized()
            contentLabel.attributedText = Rstring.mnemonic_TEXT_WARN.localized()
                .styled(with: common_style)
            subTitle.text = Rstring.mnemonic_SUB_TITLE.localized()
            contextText.placeholder = Rstring.mnemonic_SUB_Holder.localized() as NSString
            nextBtn.setTitle(Rstring.common_Nextstep.localized(), for: .normal)
            setPwdTitle.text = Rstring.setting_PWD.localized()
            setPwdText.placeholder = Rstring.setting_PWD.localized()
            pwdLimit.text = Rstring.pwd_LIMIT.localized()
            pwdLevel.text = Rstring.pwd_LEVEL1.localized()
            repeatPwdTitle.text = Rstring.repeat_PWD.localized()
            repeatText.placeholder = Rstring.repeat_PWD.localized()
            contextText.maximumNumberOfLines = 2
            firstLimit.isHidden = true
            break
        case .register:
            setPwdTitle.text = Rstring.setting_PWD.localized()
            setPwdText.placeholder = Rstring.setting_PWD.localized()
            repeatPwdTitle.text = Rstring.repeat_PWD.localized()
            repeatText.placeholder = Rstring.repeat_PWD.localized()
            contextText.maximumNumberOfLines = 1
            contentLabel.text = Rstring.built_username_limit.localized()
            titleLabel.text =  Rstring.built_create_username.localized()
            subTitle.text = Rstring.built_create_username.localized()
            firstLimit.isHidden = true
            nextBtn.setTitle(Rstring.common_Nextstep.localized(), for: .normal)
            break
        }
        
        if #available(iOS 11.0, *) {} else {
        let offset = kScreenW * -1
            backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
        }
        
        contextText.becomeFirstResponder()
        contextText.delegate = self
        thirdLimit.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNav()
        hiddenNav(false)
        if #available(iOS 11.0, *) {} else {
            let offset = kScreenW * 0
            backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
        }

    }
    
    // MARK: - Outlet action
    @IBAction func nextButtonAction(_ sender: Any) {
        if disPlayType == .keystore {
            switch import_Step {
            case .import_one:
                guard checkImg.isHidden == false else {
                    self.hudShow(Rstring.geth_INPUT_ERROR.localized())
                    return
                }
                let offset = kScreenW * 1
                setPwdText .text = ""
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle(Rstring.common_Confirm.localized(), for: .normal)
                import_Step = .import_two
                setPwdText.becomeFirstResponder()
                break
            case .import_two:
                let pwdInput = setPwdText.text
                guard !(pwdInput?.isEmpty)! else {
                    self.hudShow(Rstring.setting_PWD.localized())
                    return
                }
                setPwdText.resignFirstResponder()
                createAccountByKeystore()
                break
            case .import_three:
                break
            }
        } else if disPlayType == .mnemonic {
            switch import_Step {
            case .import_one:
                guard checkImg.isHidden == false else {
                    self.hudShow(Rstring.mnemonic_TEXT_ERROR.localized())
                    return
                }
                setPwdText.text = ""
                let offset = kScreenW * 1
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle(Rstring.common_Nextstep.localized(), for: .normal)
                import_Step = .import_two
                setPwdText.becomeFirstResponder()
                break
            case .import_two:
                let pwdInput = setPwdText.text
                guard !(pwdInput?.isEmpty)! else {
                    self.hudShow(Rstring.setting_PWD.localized())
                    return
                }
                if pwdInput!.count < (PASSWORD_LIMIT_COUNT - 1) {
                    self.hudShow(Rstring.pwd_LIMIT.localized())
                    return
                }
                repeatText.text = ""
                let offset = kScreenW * 2
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle(Rstring.common_Confirm.localized(), for: .normal)
                repeatText.becomeFirstResponder()
                import_Step = .import_three
                break
            case .import_three:
                let pwdInput = repeatText.text
                guard !(pwdInput?.isEmpty)! else {
                    self.hudShow(Rstring.repeat_PWD.localized())
                    return
                }
                if checkImg2.isHidden {
                    self.hudShow(Rstring.different_PWD.localized())
                    return
                }
                repeatText.resignFirstResponder()
                builtAccountByMnemonic()
                break
            }
        } else if disPlayType == .register {
            switch import_Step {
            case .import_one:
                guard checkImg.isHidden == false else {
                    self.hudShow(Rstring.username_formated_error.localized())
                    return
                }
                setPwdText.text = ""
                let offset = kScreenW * 1
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle(Rstring.common_Nextstep.localized(), for: .normal)
                let common_style = StringStyle(
                    .font(UIFont.systemFont(ofSize: 15)),
                    .color(Rcolor.c666666()),
                    .lineSpacing(5))
                contentLabel.attributedText = Rstring.built_WALLET_WARN.localized().styled(with: common_style)
                titleLabel.text =  Rstring.setting_PWD.localized()
                import_Step = .import_two
                setPwdText.becomeFirstResponder()
                break
            case .import_two:
                let pwdInput = setPwdText.text
                guard !(pwdInput?.isEmpty)! else {
                    self.hudShow(Rstring.setting_PWD.localized())
                    return
                }
                if pwdInput!.count < (PASSWORD_LIMIT_COUNT - 1) {
                    self.hudShow(Rstring.pwd_LIMIT.localized())
                    return
                }
                repeatText.text = ""
                let offset = kScreenW * 2
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle(Rstring.common_Confirm.localized(), for: .normal)
                repeatText.becomeFirstResponder()
                import_Step = .import_three
                break
            case .import_three:
                let pwdInput = repeatText.text
                guard !(pwdInput?.isEmpty)! else {
                    self.hudShow(Rstring.repeat_PWD.localized())
                    return
                }
                if checkImg2.isHidden {
                    self.hudShow(Rstring.different_PWD.localized())
                    return
                }
                repeatText.resignFirstResponder()
                createAccount()
                break
            }
        }

    }
    
    @IBAction func endEdit(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func builtAccountByMnemonic()  {
        self.setButtonLoad(isLoad: true)
        let mnemonic = contextText.text!
        let password = setPwdText.text!
        
        let account = Account(mnemonicPhrase: mnemonic)
        _ = account?.encryptSecretStorageJSON(password, callback: { (json) in
            let data = json!.data(using: .utf8)
            GethTool.importJsonKey(jsonKey: data!,
                                   passphrase: password,
                                   handle: { (account) in
                                    debugPrint("import account hex address --- \((account.getAddress().getHex())!)")
                                    // hud.hide(animated: true)
                                    self.setButtonLoad(isLoad: false)
                                    X_Notification.post(GET_Notification(.register_Finish))

            }, err: { (error) in
                // hud.hide(animated: true)
                if IS_PwdError(error) {
                    self.hudShow(Rstring.pwd_ERROR.localized())
                } else {
                    self.hudShow(error.localizedDescription)
                }
                self.setButtonLoad(isLoad: false)
            })
        })
    }
    
    
    func createAccountByKeystore()  {
        setButtonLoad(isLoad: true)
        let keystore = contextText.text!
        let password = setPwdText.text!
        
        let data = keystore.data(using: .utf8)
        // let hud = self.hudLoading("IMPORT_KEYSTORE".localized)
        GethTool.importJsonKey(
            jsonKey: data!,
            passphrase: password,
            handle: { (account) in
                debugPrint("import account hex address --- \((account.getAddress().getHex())!)")
                // hud.hide(animated: true)
                self.setButtonLoad(isLoad: false)
                X_Notification.post(GET_Notification(.register_Finish))
        })
        { (error) in
            // hud.hide(animated: true)
            if IS_PwdError(error) {
                self.hudShow(Rstring.pwd_ERROR.localized())
            } else {
                self.hudShow(GethErrorLog(error))
            }
            self.setButtonLoad(isLoad: false)
        }
    }
    
    // MARK: - Create account
    func createAccount()  {
        self.setButtonLoad(isLoad: true)

        let pwdInput = setPwdText.text
        let username = contextText.text
        
        let account = Account.randomMnemonic()
        let password = pwdInput
        let mnemonicPhrase = account?.mnemonicPhrase
        debugPrint("created accpint address --- \(account!.address!)")
        debugPrint("created accpint mnemonic --- \(mnemonicPhrase!)")
        
        _ = account?.encryptSecretStorageJSON(pwdInput, callback: { (json) in
            let data = json?.data(using: .utf8)
            GethTool.removeALLKeystore()

            // import account
            GethTool.importJsonKey(
                jsonKey: data!,
                passphrase: password!,
                handle: { (_) in
                    // update username
                    UserAPI.updateUserName(
                        name: username!,
                        passphrase: password!,
                        suc: { userModel in
                            UserTool.shared.initUserModel(user: userModel)
                            self.setButtonLoad(isLoad: false)
                            let mnonic = Rstoryboard.builtWallet.helpWordPage()!
                            mnonic.mnonicPhrase = mnemonicPhrase!
                            self.pushVc(mnonic)
                    }, err: { (error) in
                        debugPrint(error.localizedDescription)
                        self.setButtonLoad(isLoad: false)
                        self.hudShow(error.localizedDescription)
                    })
                    }, err: { (error) in
                        debugPrint(error.localizedDescription)
                        self.hudShow(error.localizedDescription)
                    })
        })
    }
    
    // set loading button
    func setButtonLoad(isLoad: Bool)  {
        if isLoad {
            loading = true
            nextBtn.isUserInteractionEnabled = false
            nextBtn.setTitle("", for: .normal)
            self.activity = UIActivityIndicatorView.init(frame: nextBtn.bounds)
            activity.startAnimating()
            nextBtn.addSubview(activity)
            self.view.isUserInteractionEnabled = false
            repeatText.isUserInteractionEnabled = false
            setPwdText.isUserInteractionEnabled = false
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        } else {
            loading = false
            nextBtn.isUserInteractionEnabled = true
            self.activity.removeFromSuperview()
            nextBtn.setTitle(Rstring.common_Confirm.localized(), for: .normal)
            self.view.isUserInteractionEnabled = true
            repeatText.isUserInteractionEnabled = true
            setPwdText.isUserInteractionEnabled = true
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        }
    }
    
    /// set password action
    @objc func pwdEditing() {
        if disPlayType == .keystore  { return }
        let text = setPwdText.text
        if !(text?.isEmpty)! {
            pwdLimit.text = "\("TEXT_ENTERED".localized) \(text!.count) \("SOME_CHARACTER".localized)"
            pwdLevel.isHidden = false
            pwdLevelImg.isHidden = false
            let level = judgePwdLevel(pwd: text!)
            if level == .high_level {
                pwdLevel.text = "PWD_LEVEL3".localized
                pwdLevelImg.image = UIImage.init(named: "strong")
            } else if level == .middel_level {
                pwdLevel.text = "PWD_LEVEL2".localized
                pwdLevelImg.image = UIImage.init(named: "middle")
            } else {
                pwdLevel.text = "PWD_LEVEL1".localized
                pwdLevelImg.image = UIImage.init(named: "weak")
            }
        } else {
            pwdLevel.isHidden = true
            pwdLevelImg.isHidden = true
            pwdLimit.text = "PWD_LIMIT".localized
        }
    }
    
    @objc func pwd2Editing() {
        if setPwdText.text == repeatText.text {
            checkImg2.isHidden = false
        } else {
            checkImg2.isHidden = true
        }
    }
    
    // MARK: - Private
    @objc func contentText()  {
        
        let input = contextText.text
        guard !(input?.isEmpty)! else {
            checkImg.isHidden = true
            return
        }
        
        switch disPlayType {
        case .keystore:
            let data = input?.data(using: .utf8)
            do {
               _ = try JSONSerialization.jsonObject(
                with: data!,
                options: [.allowFragments])
                checkImg.isHidden = false
            } catch {
                checkImg.isHidden = true
            }
            break
        case .mnemonic:
            if Account.isValidMnemonicPhrase(input) {
                checkImg.isHidden = false
            } else {
                checkImg.isHidden = true
            }
            break
        case .register:
            if input?.count < USERNAME_LIMIT_COUNT{
                checkImg.isHidden = false
            } else {
                checkImg.isHidden = true
            }
            break
        }
    }
    
    // pop nav
    @objc func popAction()  {
        
        if loading { return }
        
        if disPlayType == .keystore {
            switch import_Step {
            case .import_one:
                self.navigationController?.popViewController(animated: true)
                break
            case .import_two:
                GethTool.removeALLKeystore()
                let offset = 0
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0),
                                               animated: true)
                nextBtn.setTitle("COMMOM_NEXT_STEP".localized, for: .normal)
                setPwdText.text = ""
                import_Step = .import_one
                contextText.becomeFirstResponder()
                break
            case .import_three:
                break
            }
        } else if disPlayType == .mnemonic {
            switch import_Step {
            case .import_one:
                self.navigationController?.popViewController(animated: true)
                break
            case .import_two:
                let offset = 0
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle("COMMOM_NEXT_STEP".localized, for: .normal)
                pwdLevel.isHidden = true
                pwdLevelImg.isHidden = true
                pwdLimit.text = "PWD_LIMIT".localized
                import_Step = .import_one
                contextText.becomeFirstResponder()
                break
            case .import_three:
                GethTool.removeALLKeystore()
                let offset = kScreenW
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle("COMMOM_NEXT_STEP".localized, for: .normal)
                checkImg2.isHidden = true
                import_Step = .import_two
                repeatText.resignFirstResponder()
                setPwdText.becomeFirstResponder()
                blueLine2.isHidden = false
                break
            }
        } else if disPlayType == .register {
            switch import_Step {
            case .import_one:
                self.navigationController?.popViewController(animated: true)
                break
            case .import_two:
                contentLabel.text = Rstring.built_username_limit.localized()
                let offset = 0
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                titleLabel.text =  Rstring.built_create_username.localized()
                nextBtn.setTitle(Rstring.common_Nextstep.localized(), for: .normal)
                pwdLevel.isHidden = true
                pwdLevelImg.isHidden = true
                pwdLimit.text = "PWD_LIMIT".localized
                import_Step = .import_one
                contextText.becomeFirstResponder()
                break
            case .import_three:
                GethTool.removeALLKeystore()
                let offset = kScreenW
                backScollview.setContentOffset(CGPoint.init(x: offset, y: 0), animated: true)
                nextBtn.setTitle("COMMOM_NEXT_STEP".localized, for: .normal)
                checkImg2.isHidden = true
                import_Step = .import_two
                repeatText.resignFirstResponder()
                setPwdText.becomeFirstResponder()
                blueLine2.isHidden = false
                break
            }
        }
    }
    
    // MARK: - UITextViewDelegate
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        blueLine1.isHidden = false
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        blueLine1.isHidden = true
        return true
    }
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            nextButtonAction(self)
            return false
        }
        return true
    }

    // MARK: - UITextViewDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == setPwdText {
            blueLine2.isHidden = false
        }
        if textField == repeatText {
            blueLine3.isHidden = false
        }
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == setPwdText {
            blueLine2.isHidden = true
        }
        if textField == repeatText {
            blueLine2.isHidden = true
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch disPlayType {
        case .keystore:
            break
        case .mnemonic:
            break
        case .register:
            break
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
