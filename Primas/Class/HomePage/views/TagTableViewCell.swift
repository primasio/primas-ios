//
//  TagTableViewCell.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/19.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class TagTableViewCell: BaseTableViewCell {

    fileprivate var tagsArray:Array<String> = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        let flow = UICollectionViewFlowLayout.init()
        flow.minimumLineSpacing = tagsLineSpacing
        let width = (kScreenW - 30 * 3) / 3
        flow.itemSize = CGSize.init(width: width, height: tagsHeigt)
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.scrollDirection = .vertical
        collectionView.collectionViewLayout = flow
        collectionView.register(Rnib.tagCollectionCell)
        self.selectionStyle = .none
    }

    // MARK: - Cell height
    open static func cellHeight(count: Int) -> CGFloat {
        let singleH = tagsHeigt + tagsLineSpacing
        var num = 0
        num = count / 3
        if count % 3 > 0 {
            num = num + 1
        }
        return singleH * CGFloat.init(num) + 70
    }
    
    func getCollectionHeight(count: Int) {

    }
    
    // MARK: - Pass Data
    open func setTagsData(tags: Array<String>)  {
        self.tagsArray = tags
        self.collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: -  UICollectionViewDelegate, UICollectionViewDataSource

extension TagTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell:TagCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RreuseIdentifier.tagCollectionCell, for: indexPath)!
        if !(tagsArray.isEmpty) {
            tagCell.contentLabel.text = tagsArray[indexPath.row]
        }
        return tagCell
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !(tagsArray?.isEmpty)! {
            let margin:CGFloat = 20
            let addMargin:CGFloat = 3
            let height:CGFloat = 30
            let content = tagsArray![indexPath.row]
            let font = UIFont.systemFont(ofSize: 12)
            let width = Utility.getLabWidth(content, font: font, height: height)
            return CGSize.init(width: width + margin * 2 + addMargin, height: height)
        }
        return CGSize.init(width: 0, height: 0)
    }
  */
}
