//
//  RepoData.swift
//  Created on November 15, 2019

import Foundation

class RepoData {

    var forksCount : Int!
    var fullName : String!
    var stargazersCount : Int!
    var name : String!
    var svn_url : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]) {
        
        forksCount = dictionary["forks_count"] as? Int
        fullName = dictionary["full_name"] as? String
        name = dictionary["name"] as? String
        stargazersCount = dictionary["stargazers_count"] as? Int
        svn_url = dictionary["svn_url"] as? String
    }
}
