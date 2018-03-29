//
//  CycleCell.swift
//  Primas
//
//  Created by admin on 2017/12/22.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

protocol  CycleFollowDelegate: NSObjectProtocol{
    func onFollowClicked(cell: CycleCell)
}

class CycleCell: BaseTableViewCell {
    @IBOutlet weak var cycleIcon: UIImageView!
    @IBOutlet weak var cycleTitle: UILabel!
    @IBOutlet weak var cycleInfo: UILabel!
    @IBOutlet weak var cycleDes: UILabel!
    @IBOutlet weak var cycleUpdate: UILabel!
    @IBOutlet weak var cycleState: UILabel!
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var btnWidth: NSLayoutConstraint!
    
    weak var delegate: CycleFollowDelegate?

    
    var model: CycleModel!{
        didSet {
            cycleTitle.text = model.Title;
            cycleInfo.text = model.get_info_string();
            cycleDes.text = model.Description;
            updateState()
        }
    }
    
    var inDiscover = false
    
    func updateState() {

        followBtn.isHidden = true
        cycleUpdate.isHidden = true
        
        if inDiscover {
            cycleState.isHidden = true
        } else {
            if model.IsMember == nil {
                cycleState.isHidden = false
                if model.TxStatus == 1 {
                    cycleState.text = Rstring.post_to_auditting.localized()
                    cycleState.backgroundColor = Color_ED5634
                    cycleState.textColor = UIColor.white
                } else  {
                    cycleState.text = Rstring.cycle_my_joined.localized()
                    cycleState.backgroundColor = UIColor.white
                    cycleState.textColor = Rcolor.c333333()
                }
            } else {
                cycleState.isHidden = false
                if  model.IsMember?.TxStatus == "1" {
                    cycleState.text = Rstring.post_to_auditting.localized()
                    cycleState.backgroundColor = Rcolor.ed5634()
                } else {
                    cycleState.text = Rstring.cycle_my_joined.localized()
                    cycleState.backgroundColor = Rcolor.c999999()
                }
            }
           btnWidth.constant = Utility.getLabWidth(cycleState.text!, font: UIFont.systemFont(ofSize: 10), height: 12) + 5
        }

        
            /*
            if !cycleUpdate.isHidden {
                cycleUpdate.text = String(model.update_num);
                let width = (cycleUpdate.text?.getMaxWidth(font: cycleUpdate.font))! + 14
                cycleUpdate.width = width
                cycleUpdate.right = content.width-4
            } else {
                if model.follow_state == 1{
                followBtn.setTitle(Rstring.cycle_followed.localized(), for: .normal)
                followBtn.setTitleColor(Color_102, for: .normal)
            } else {
                followBtn.setTitle(Rstring.cycle_un_followed.localized(), for: .normal)
                followBtn.setTitleColor(Color_custom_red, for: .normal)
            }
            followBtn.isUserInteractionEnabled = model.follow_state == 0
        }
        */
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cycleIcon.contentMode = .scaleAspectFill
        cycleIcon.layer.masksToBounds = true
        cycleIcon.image = Utility.randomImg()
        cycleState.setCornerRadius(radius: 2)
        cycleUpdate.setCornerRadius(radius: 8)
        content.setCornerRadius(radius: 5)

        cycleUpdate.frame = CGRect.init(x: content.width-24, y: 4, width: 20, height: 16)
        cycleState.frame = CGRect.init(x: cycleIcon.left+(cycleIcon.width-100)/2, y: cycleIcon.bottom-30, width: 100, height: 20)
        // Initialization code
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func onFollowClick(){
        if (delegate != nil) {
            delegate?.onFollowClicked(cell: self)
        }
    }
    
}
