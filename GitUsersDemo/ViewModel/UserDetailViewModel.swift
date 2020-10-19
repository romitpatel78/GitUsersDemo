//
//  UserViewModel.swift
//  GitUsersDemo
//
//  Created by Romit Patel on 15/11/19.
//  Copyright © 2019 Romit Patel. All rights reserved.
//

import Foundation

class UserDetailViewModel {
    
    var userDetail = UserDetailData(fromDictionary: [:])
    var reposList = [RepoData]()
    var reposSearchedList = [RepoData]()
    var reloadDelegate: reloadTableViewDelegate?
    
    init(viewDelegate: reloadTableViewDelegate) {
        self.reloadDelegate = viewDelegate
    }
    
    func addRepos(data : [Any]) {
        
        for dic in data {
            
            if let userSingleData = dic as? [String : Any] {
                let value = RepoData(fromDictionary: userSingleData)
                self.reposList.append(value)
            }
        }
        if let dele = self.reloadDelegate {
            dele.reloadTableView()
        }
    }
}

//MARK: - API -

extension UserDetailViewModel {
        
    func getUserDetail(userName:String){
        
        guard let url = URL(string: "\(APIEndpoints.users)/\(userName)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let err = error {
                print(err)
                return
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: Data(data!), options:  JSONSerialization.ReadingOptions()) as? [String : Any] else { return }
            self.userDetail = UserDetailData(fromDictionary: json)
            
            if let dele = self.reloadDelegate {
                DispatchQueue.main.async {
                    dele.displayData()
                }
                
            }
        })

        task.resume()
    }
    
    func getReposList(userName:String){
        
        guard let url = URL(string: "\(APIEndpoints.users)/\(userName)/repos") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //request.httpBody = try? JSONSerialization.data(withJSONObject: [:], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            if let err = error {
                print(err)
                return
            }
            
            guard let json = try! JSONSerialization.jsonObject(with: Data(data!), options:  JSONSerialization.ReadingOptions()) as? [Any] else { return }
            self.addRepos(data: json)
        })

        task.resume()
    }
}
