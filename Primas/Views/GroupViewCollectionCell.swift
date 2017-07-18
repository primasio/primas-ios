//
//  GroupViewCollectionCell.swift
//  Primas
//
//  Created by 甘露 on 14/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import UIKit
import SnapKit

class GroupViewCollectionCell: UICollectionViewCell
{
    static let identifier = "GroupViewCollectionCell"
    
    var image: UIImageView?
    var name: UILabel?
    var info: UILabel?
    var news: UILabel?
    
    func setItem(item: [String: Any]) -> Void {
        name?.text = item["name"] as? String
        let _url = URL(string: app().client.baseURL + (item["image"] as! String))
        image?.kf.setImage(with: _url)
        
        let totalContent = item["content_total"] as! Int
        let totalPeople = item["member_total"] as! Int
        
        info?.text = "内容：\(totalContent)  人数：\(totalPeople)"
        info?.font = UIFont(name: (info?.font.fontName)!, size: 12)
        
        let totalNews = item["content_new"] as! Int
        news?.text = "\(totalNews)条新内容"
        news?.font = UIFont(name: (news?.font.fontName)!, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        image = UIImageView()
        name = UILabel()
        info = UILabel()
        news = UILabel()
        
        name?.textAlignment = .center
        info?.textAlignment = .center
        news?.textAlignment = .center
        
        info?.textColor = UIColor.darkGray
        news?.textColor = UIColor.lightGray
        
        self.addSubview(image!)
        self.addSubview(name!)
        self.addSubview(info!)
        self.addSubview(news!)
        
        image!.snp.makeConstraints {
            make in
            make.top.equalTo(self).offset(20.0)
            make.left.equalTo(self).offset(40.0)
            make.right.equalTo(self).offset(-40.0)
            make.size.height.equalTo(image!.snp.width)
        }
        
        name!.snp.makeConstraints {
            make in
            make.top.equalTo(image!.snp.bottom).offset(15.0)
            make.left.right.equalTo(self)
            make.size.height.equalTo(10.0)
        }
        
        info!.snp.makeConstraints {
            make in
            make.top.equalTo(name!.snp.bottom).offset(15.0)
            make.left.right.equalTo(self)
            make.size.height.equalTo(10.0)
        }
        
        news!.snp.makeConstraints {
            make in
            make.top.equalTo(info!.snp.bottom).offset(15.0)
            make.left.right.equalTo(self)
            make.size.height.equalTo(10.0)
        }
    }
}
