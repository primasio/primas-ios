//
//  TagsPage.swift
//  Primas
//
//  Created by xuxiwen on 2017/12/20.
//  Copyright © 2017年 xuxiwen. All rights reserved.
//

import UIKit

class TagsPage: BaseViewController {

    let add_tags_string = " 添加 "
    
    lazy var selectTags: [String] = {
        return []
    }()
    
    var tagsBlock: arrayBlock?
    
    fileprivate var tagsArray:Array<String> = []
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // nav set
        self.navigationItem.title = Rstring.common_add_tags.localized()
        let rightBaritem = UIBarButtonItem.init(
            title: Rstring.common_Confirm.localized(),
            style: .plain,
            target: self,
            action: #selector(finishSelect))
        rightBaritem.tintColor = Rcolor.ed5634()
        self.navigationItem.rightBarButtonItem = rightBaritem
        self.navigationItem.leftBarButtonItem =
            UIBarButtonItem.init(
                image: Rimage.guanbi()!.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(dissMiss))
        
        // collection set
        let flow = UICollectionViewFlowLayout.init()
        flow.minimumLineSpacing = 15
        let width = (kScreenW - 30 * 3) / 3
        flow.itemSize = CGSize.init(width: width, height: 27)
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.scrollDirection = .vertical
        collectionView.collectionViewLayout = flow
        collectionView.register(Rnib.tagCollectionCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tagsArray.append("科技")
        tagsArray.append("生活")
        tagsArray.append("比特币")
        tagsArray.append("时政")
        tagsArray.append("金融")
        tagsArray.append("互联网")
        tagsArray.append("帅哥")
        tagsArray.append("美女")
        tagsArray.append("摄像")
        
        tagsArray.append(add_tags_string)
    }
    
    @objc func finishSelect()  {
        if tagsBlock != nil {
            tagsBlock!(selectTags)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dissMiss()  {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSelectTags(tag: String)  {
        if selectTags.contains(tag) {
            selectTags.remove(at: selectTags.index(of: tag)!)
        } else {
            selectTags.append(tag)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TagsPage: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tagCell:TagCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: RreuseIdentifier.tagCollectionCell, for: indexPath)!
        if !(tagsArray.isEmpty) {
            let content = tagsArray[indexPath.row]
            tagCell.contentLabel.text = content
            if content == add_tags_string {
                tagCell.setTags(display: .show)
            } else {
                if PostArticle.shared.tags.contains(content) || selectTags.contains(content) {
                    tagCell.setTags(display: .selected)
                } else {
                    tagCell.setTags(display: .select)
                }
            }
        }
        return tagCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !tagsArray.isEmpty {
            let content = tagsArray[indexPath.row]
            if content == add_tags_string {
                // Go to add tag page
                let vc = Rstoryboard.noticeView.noticeAddTags()!
                vc.blockTag = { (tag) in
                    self.tagsArray.insert(tag, at: 0)
                    self.addSelectTags(tag: tag)
                    self.collectionView.reloadData()
                }
                vc.modalPresentationStyle = .overCurrentContext
                self.presentVc(vc, animated: false)
            } else {
                let cell:TagCollectionCell = collectionView.cellForItem(at: indexPath) as! TagCollectionCell
                if cell.display == .select {
                    cell.setTags(display: .selected)
                } else {
                    cell.setTags(display: .select)
                }
                addSelectTags(tag: content)
            }
        }
    }
}
