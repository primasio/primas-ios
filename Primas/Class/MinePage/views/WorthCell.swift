//
//  WorthCell.swift
//  Primas
//
//  Created by figs on 2017/12/23.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class WorthCell: BaseTableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var numLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model: WorthRecord!{
        didSet{
            titleLbl.text = model.title;
            timeLbl.text = model.time;
            numLbl.text =  "+" + model.worth_num + " PST";
            updateState()
        }
    }
    
    func updateState() {
        var state_text = ""
        switch model.type {
        case "1":
            state_text = Rstring.common_orignal_author.localized()
        case "2":
            state_text = Rstring.cycle_title.localized()
        case "3":
            state_text = Rstring.common_like.localized()
        case "4":
            state_text = Rstring.common_comment.localized()
        case "5":
            state_text = Rstring.common_transimit.localized()
        default:
            state_text = Rstring.common_unknown.localized()
        }
        
        stateLbl.text = state_text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
