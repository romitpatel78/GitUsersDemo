//
//  ViewController.swift
//  GitUsersDemo
//
//  Created by Romit Patel on 15/11/19.
//  Copyright © 2019 Romit Patel. All rights reserved.
//

import UIKit
import SDWebImage


class ViewController: UIViewController {
    
    @IBOutlet weak var tblView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    var userViewModel : UserViewModel?
    var isSearchMode : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.title = "GitHub Searcher"
        userViewModel = UserViewModel(viewDelegate: self)
        userViewModel?.getUserList()
        addToolbar()
    }
    
    
    //MARK: - Functions -
    func navigateToDetailScreen(userId : String = "") {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "UserDetailViewController") as? UserDetailViewController else { return }
        vc.userName = userId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func filterContentForSearchText(searchText: String) {
        
        // Filter the array using the filter method
        if searchText.count == 0 {
            self.isSearchMode = false
            self.tblView.reloadData()
            return
        }
        self.isSearchMode = true
        
        guard let viewModel = userViewModel else { return }
        let mainList = viewModel.userList
        var searchList = viewModel.searchedUserList
        
        if mainList.count == 0 {
            searchList.removeAll()
            return
        }
        searchList = mainList.filter({( userData: UserData) -> Bool in
            // to start, let's just search by name
            return userData.login.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        viewModel.searchedUserList = searchList
        self.tblView.reloadData()
    }
    
    func addToolbar(){
        let toolBar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneWithNumberPad))]
        toolBar.sizeToFit()
        self.searchBar.inputAccessoryView = toolBar
    }
    
    @objc func doneWithNumberPad() {
        self.view.endEditing(true)
    }
}

//MARK: - TableView Methods -
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchMode {
            return userViewModel?.searchedUserList.count ?? 0
        }
        return userViewModel?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblView.dequeueReusableCell(withIdentifier: "cell") as? UserListTableViewCell else { return UITableViewCell() }
        
        guard let viewModel = userViewModel else { return cell }
        
        let data = isSearchMode ? viewModel.searchedUserList[indexPath.row] : viewModel.userList[indexPath.row]
        
        guard let username = data.login else { return cell }
        cell.lblUserName.text = "\(username)"
        
        guard let imageUrl = data.avatarUrl else { return cell }
        cell.imgProfilePic.sd_setImage(with: URL(string:imageUrl), placeholderImage: nil, options: .highPriority, context: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let viewModel = userViewModel else { return }
        
        let data = isSearchMode ? viewModel.searchedUserList[indexPath.row] : viewModel.userList[indexPath.row]
        guard let userId = data.login else { return }
        navigateToDetailScreen(userId: userId)
    }
}

//MARK: - Reload Table Delegate -
extension ViewController : reloadTableViewDelegate {
    
    func displayData() {}
    
    func reloadTableView() {
        
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
        
    }
}

//MARK: - Search field delegate -

extension ViewController : UISearchBarDelegate {
    
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
