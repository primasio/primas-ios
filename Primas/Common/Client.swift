//
//  Client.swift
//  Primas
//
//  Created by wang on 17/07/2017.
//  Copyright © 2017 wang. All rights reserved.
//

import Networking
import Foundation

class Client {
  let baseURL = "http://yb-public.oss-cn-shanghai.aliyuncs.com/primas_data/"
  var data: [String: Any]?
  var user: User?
  var groups: [Group] = []
  var articles: [Article] = []
  var system: System?
  var selectedArticleId: Int = 0

  init() {
    let networking = Networking(baseURL: "http://yb-public.oss-cn-shanghai.aliyuncs.com/primas_data/")
    networking.isSynchronous = true

    networking.get("primas.json") {
      result in 
         switch result {
          case .success(let response):
              self.data = response.dictionaryBody
              self.parse()

              let _controller = (app().cachedViewControllers[ViewControllers.home] as! HomeViewController)
              _controller.cellList = CellModel.generateTestData()
              _controller.homeView.tableView.reloadData()

          case .failure(let response):
              let errorCode = response.error.code
              let json = response.dictionaryBody // BOOM, no optionals here [String: Any]
              let headers = response.headers // [String: Any]
              
              print("error: \(errorCode) \(json) \(headers) \(response.error)")
          }
    }
    
  }

  private func parse() {
    self.parseGroups()
    self.parseUser()
    self.parseArticles()
    self.parseSystem()
  }

  private func parseGroups() {
    let _groups = self.data!["groups"] as! Array<[String: Any]>
    for item in _groups {
      let id = item["id"] as! Int 
      let name = item["name"] as! String
      let image = item["image"] as! String
      let contentTotal = item["content_total"] as! Int
      let contentNew = item["content_new"] as! Int
      let memberTotal = item["member_total"] as! Int

        self.groups.append(Group(id: id, name: name, image: image, contentTotal: contentTotal, contentNew: contentNew, memberTotal: memberTotal))
    }
  }

  private func parseSystem() {
    let _system = self.data!["system"] as! [String: Any]
    let pstYesterday = _system["pst_yesterday"] as! Double
    let articles = (_system["ranking_lists"] as! [String: Any])["articles"] as! Array<[String: Any]>
    var rankingArticles: [SystemArticleRanking] = []

    for item in articles {
      let articleId = item["id"] as! Int
      let amount = item["amount"] as! Double

      rankingArticles.append(SystemArticleRanking(articleId: articleId, amount: amount))
    }

    self.system = System(pstYesterday: pstYesterday, rankingArticles: rankingArticles, rankingGroups: [])
  }

  private func parseArticles() {
    let _articles = self.data!["articles"] as! Array<[String: Any]>
    for item in _articles {
      let id = item["id"] as! Int
      let title = item["title"] as! String
      let coverImage = item["cover_image"] as! String
      let content = item["content"] as! String
      let groupId = item["group_id"] as! Int
      let dna = item["dna"] as! String
      let outline = item["outline"] as! String
      let createdAt = item["created_at"] as! Int

      let author = item["author"] as! [String: String]
      let _author = ArticleAuthor(name: author["name"]!, avatar: author["avatar"]!)

      let license = item["license"] as! [String: Any]
      let licenseType = license["type"] as! String
      let licenseContent = license["content"] as! [String: String]
      let _license = ArticleLicense(type: licenseType, content: licenseContent)

      let source = item["source"] as! [String: Any]
      let sourceUrl = source["url"] as! String
      let sourceTitle = source["title"] as! String
      let sourceAuthor = source["author"] as! String
      let sourceLicensed = source["licensed"] as! Bool
      let _source = ArticleSource(url: sourceUrl, title: sourceTitle, author: sourceAuthor, licensed: sourceLicensed)

      let statistics = item["statistics"] as! [String: Int]
      let like = statistics["like"]
      let share = statistics["share"]
      let reproduction = statistics["reproduction"]
      let _statistics = ArticleStatistics(like: like!, share: share!, reproduction: reproduction!)

      self.articles.append(Article(id: id, title: title, author: _author, coverImage: coverImage, content: content, license: _license, source: _source, statistics: _statistics, dna: dna, outline: outline, groupId: groupId, createdAt: createdAt ))
    }
  }

  private func parseUser() {
    let _user = self.data!["user"] as! [String: Any]
    let nickname = _user["nickname"] as! String 
    let hp = _user["hp"] as! Double
    let avatar = _user["avatar"] as! String
    let credit = _user["credit"] as! Double
    let articles = _user["articles"] as! [String: Any]
    let articlesTotal = articles["total"] as! Int

    var articleItems: [UserArticleItem] = []
    for item in articles["items"] as! Array<[String: Int]> {
      articleItems.append(UserArticleItem(articleId: item["id"]!, groupId: item["group_id"]!))
    }

    let _groups = _user["groups"] as! [String: Any] 
    let groupsTotal = _groups["total"] as! Int

    let balance = _user["balance"] as! Double
    let amountYesterday = _user["amount_yesterday"] as! Double
    let amountDetails = _user["amount_detail"] as! Array<[String: Any]>
    var details: [AmountDetail] = []

    for item in amountDetails {
      let date = item["date"] as! String
      let items = item["items"] as! Array<[String: Any]> 

      var userAmountItems: [UserAmountDetailItem] = []

      for _item in items {
        let _date = _item["date"] as! String
        let _title = _item["title"] as! String
        let _amount = _item["amount"] as! Double
        let type = _item["type"] as! String
        let _type = getPrimasAwardTypeFromString(type)

        userAmountItems.append(UserAmountDetailItem(date: _date, title: _title, amount: _amount, type: _type))
      }

      details.append(AmountDetail(date: date, items: userAmountItems))
    }

    self.user = User(nickname: nickname, hp: hp, avatar: avatar, credit: credit, articlesTotal: articlesTotal, articles: articleItems, groupsTotal: groupsTotal, groups: [], balance: balance, amountYesterday: amountYesterday, amountDetail: details)
  }

  func getGroupById(_ id: Int) -> Optional<Group> {
    if self.data == nil {
      return nil
    }

    for item in self.groups {
      if item.id == id {
        return item
      }
    }

    return nil
  }

  func getArticleById(_ id: Int) -> Optional<Article> {
    if self.data == nil {
      return nil
    }

    for item in self.articles {
      if id == item.id {
        return item
      }
    }

    return nil
  }

}
