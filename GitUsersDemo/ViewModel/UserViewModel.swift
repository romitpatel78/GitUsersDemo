//
//  UserViewModel.swift
//  GitUsersDemo
//
//  Created by Romit Patel on 15/11/19.
//  Copyright © 2019 Romit Patel. All rights reserved.
//

import Foundation

protocol reloadTableViewDelegate {
    func reloadTableView()
    func displayData()
}


class UserViewModel {
    var userList = [UserData]()
    var searchedUserList = [UserData]()
    var reloadDelegate: reloadTableViewDelegate?
    
    init(viewDelegate: reloadTableViewDelegate) {
        self.reloadDelegate = viewDelegate
    }
    
    func addUsers(data : [Any]) {
        
        for dic in data {
            
            if let userSingleData = dic as? [String : Any] {
                let value = UserData(fromDictionary: userSingleData)
                self.userList.append(value)
            }
        }
        if let dele = self.reloadDelegate {
            dele.reloadTableView()
        }
    }
}

//MARK: - API -

extension UserViewModel {
        
    func getUserList(){
        
        guard let url = URL(string: APIEndpoints.users) else { return }
        
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
            self.addUsers(data: json)
        })

        task.resume()
    }
}
