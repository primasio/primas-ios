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

  init() {
    let networking = Networking(baseURL: "http://yb-public.oss-cn-shanghai.aliyuncs.com/primas_data/")
    networking.isSynchronous = true

    networking.get("primas.json") {
      result in 
         switch result {
          case .success(let response):
              self.data = response.dictionaryBody

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

  // private func parseArticles() {
  //   let _articles = self.data!["articles"] as! Array<[String: Any]>
  //   for item in _articles {
  //     let id = item["id"] as! Int
  //     let title = item["title"] as! String
  //   }
  // }

  private func parseUser() {
    let _user = self.data!["user"] as! [String: Any]
    let nickname = _user["nickname"] as! String 
    let avatar = _user["avatar"] as! String
    let credit = _user["credit"] as! Double
    let articles = _user["articles"] as! [String: Any]
    let articlesTotal = articles["total"] as! Int
    var articleItems: [UserArticleItem] = []
    for item in articles["items"] as! Array<[String: Int]> {
      articleItems.append(UserArticleItem(articleId: item["id"]!, groupId: item["group_id"]!))
    }

    let _groups = _user["groups"] as! [String: Any] 
    let groupsTotal = _groups[""]
  }

  func getGroupById(_ id: Int) -> Optional<[String: Any]> {
    if self.data == nil {
      return nil
    }

    let _groups = data?["groups"] as! Array<[String: Any]>
    for item in _groups {
      let _id = item["id"] as! Int 
      if _id == id {
        return item
      }
    }

    return nil
  }

  func getArticleById(_ id: Int) -> Optional<[String: Any]> {
    if self.data == nil {
      return nil
    }

    let _articles = data?["articles"] as! Array<[String: Any]>
    for item in _articles {
      let _id = item["id"] as! Int
      if _id == id {
        return item
      }
    }

    return nil
  }
}
