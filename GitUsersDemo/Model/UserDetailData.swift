//
//  UserDetailData.swift
//  Created on November 15, 2019

import Foundation


class UserDetailData {

    var avatarUrl : String!
    var bio : AnyObject!
    var blog : String!
    var company : AnyObject!
    var createdAt : String!
    var email : String!
    var eventsUrl : String!
    var followers : Int!
    var followersUrl : String!
    var following : Int!
    var followingUrl : String!
    var gistsUrl : String!
    var gravatarId : String!
    var hireable : AnyObject!
    var htmlUrl : String!
    var id : Int!
    var location : String!
    var login : String!
    var name : String!
    var nodeId : String!
    var organizationsUrl : String!
    var publicGists : Int!
    var publicRepos : Int!
    var receivedEventsUrl : String!
    var reposUrl : String!
    var siteAdmin : Bool!
    var starredUrl : String!
    var subscriptionsUrl : String!
    var type : String!
    var updatedAt : String!
    var url : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        avatarUrl = dictionary["avatar_url"] as? String
        //bio = dictionary["bio"] as? AnyObject
        blog = dictionary["blog"] as? String
       // company = dictionary["company"] as? AnyObject
        createdAt = dictionary["created_at"] as? String
        email = dictionary["email"] as? String
        eventsUrl = dictionary["events_url"] as? String
        followers = dictionary["followers"] as? Int
        followersUrl = dictionary["followers_url"] as? String
        following = dictionary["following"] as? Int
        followingUrl = dictionary["following_url"] as? String
        gistsUrl = dictionary["gists_url"] as? String
        gravatarId = dictionary["gravatar_id"] as? String
       // hireable = dictionary["hireable"] as? AnyObject
        htmlUrl = dictionary["html_url"] as? String
        id = dictionary["id"] as? Int
        location = dictionary["location"] as? String
        login = dictionary["login"] as? String
        name = dictionary["name"] as? String
        nodeId = dictionary["node_id"] as? String
        organizationsUrl = dictionary["organizations_url"] as? String
        publicGists = dictionary["public_gists"] as? Int
        publicRepos = dictionary["public_repos"] as? Int
        receivedEventsUrl = dictionary["received_events_url"] as? String
        reposUrl = dictionary["repos_url"] as? String
        siteAdmin = dictionary["site_admin"] as? Bool
        starredUrl = dictionary["starred_url"] as? String
        subscriptionsUrl = dictionary["subscriptions_url"] as? String
        type = dictionary["type"] as? String
        updatedAt = dictionary["updated_at"] as? String
        url = dictionary["url"] as? String
    }
}
