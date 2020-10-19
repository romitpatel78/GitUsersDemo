//
//  UserDetailViewController.swift
//  GitUsersDemo
//
//  Created by Romit Patel on 15/11/19.
//  Copyright © 2019 Romit Patel. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet weak var tblView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var lblUserName : UILabel!
    @IBOutlet weak var lblEmail : UILabel!
    @IBOutlet weak var lblLocation : UILabel!
    @IBOutlet weak var lblJoinDate : UILabel!
    @IBOutlet weak var lblFollowers : UILabel!
    @IBOutlet weak var lblFollowing : UILabel!
    @IBOutlet weak var imgProfilePic : UIImageView!
    
    var userDetailViewModel : UserDetailViewModel?
    var userName = ""
    var isSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GitHub Searcher"
        searchBar.delegate = self
        userDetailViewModel = UserDetailViewModel(viewDelegate: self)
        userDetailViewModel?.getUserDetail(userName: userName)
        userDetailViewModel?.getReposList(userName: userName)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions -
    func filterContentForSearchText(searchText: String) {
        
        // Filter the array using the filter method
        if searchText.count == 0 {
            self.isSearchMode = false
            self.tblView.reloadData()
            return
        }
        self.isSearchMode = true
        
        guard let viewModel = userDetailViewModel else { return }
        let mainList = viewModel.reposList
        var searchList = viewModel.reposSearchedList
        
        if mainList.count == 0 {
            searchList.removeAll()
            return
        }
        searchList = mainList.filter({( repoData: RepoData) -> Bool in
            // to start, let's just search by name
            return repoData.name.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        viewModel.reposSearchedList = searchList
        self.tblView.reloadData()
    }
    
}
//MARK: - TableView Methods -
extension UserDetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchMode {
            return userDetailViewModel?.reposSearchedList.count ?? 0
        }
        return userDetailViewModel?.reposList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as? UserRepositoriesTableViewCell else { return UITableViewCell() }
        
        guard let viewModel = userDetailViewModel else { return cell }

        let data = isSearchMode ? viewModel.reposSearchedList[indexPath.row] : viewModel.reposList[indexPath.row]

        guard let repoName = data.name else { return cell }
        cell.lblRepoName.text = "RepoName: \(repoName)"
        
        guard let forks = data.forksCount else { return cell }
        cell.lblForks.text = "\(forks) Forks"
        
        guard let stars = data.stargazersCount else { return cell }
        cell.lblRatings.text = "\(stars) Stars"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = userDetailViewModel else { return }

        let data = isSearchMode ? viewModel.reposSearchedList[indexPath.row] : viewModel.reposList[indexPath.row]

        guard let svn_url = data.svn_url else { return }
        guard let url = URL(string: svn_url) else { return }
        UIApplication.shared.open(url)
    }
}

//MARK: - Reload Table Delegate -
extension UserDetailViewController : reloadTableViewDelegate {
    
    func displayData() {
        
        guard let userData = self.userDetailViewModel?.userDetail else { return }
        
        if let userName = userData.login {
            lblUserName.text = "UserName : \(userName)"
        }
        
        if let email = userData.email {
            lblEmail.text = "Email : \(email)"
        }
        
        if let location = userData.location {
            lblLocation.text = "Location : \(location)"
        }
        
        if let joinDate = userData.createdAt {
            let dateFormatter = DateFormatter()
            //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dt = dateFormatter.date(from: joinDate)
            lblJoinDate.text = "Joining Date : \(dateFormatter.string(from: dt ?? Date()))"
        }
        
        if let followers = userData.followers {
            lblFollowers.text = "Followers : \(followers)"
        }
        
        if let following = userData.following {
            lblFollowing.text = "Following : \(following)"
        }
        
        guard let imageUrl = userData.avatarUrl else { return  }
        self.imgProfilePic.sd_setImage(with: URL(string:imageUrl), placeholderImage: nil, options: .highPriority, context: nil)
    }
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
    }
}
//MARK: - Search field delegate -

extension UserDetailViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContentForSearchText(searchText: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return isSearchMode = false}
        
        if searchText.count > 0 {
            isSearchMode = true
            return
        }
        
        isSearchMode = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { self.searchBar.endEditing(true)
            return }
        self.filterContentForSearchText(searchText: searchText)
        self.searchBar.endEditing(true)
    }
   
}
