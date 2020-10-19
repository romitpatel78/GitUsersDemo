
//  UserData.swift

import Foundation

class UserData {
    
    var avatarUrl : String!
    var login : String!
    var reposUrl : String!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        avatarUrl = dictionary["avatar_url"] as? String
        login = dictionary["login"] as? String
        reposUrl = dictionary["repos_url"] as? String
    }
}
