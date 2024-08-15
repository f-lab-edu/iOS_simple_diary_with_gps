//
//  PostListViewController.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/8/24.
//

import UIKit
import Combine

class PostListViewController: UIViewController {

    var viewModel : PostListViewModel = PostListViewModel(service: PostServiceImp())
    
    var addPostButton : UIButton!
    var listView : UITableView!
    
    var cancellable : Set<AnyCancellable> = Set()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupListView()
        
        viewModel.onEvent.sink { event in
            switch event {
            case .postUpdated :
                self.listView.reloadData()
            default :
                break
            }
        }.store(in: &cancellable)
    }
    
    func setupAddPostButton() {
    }
    
    func setupListView() {
        listView = UITableView()
        
        listView.register(nil, forCellReuseIdentifier: PostListCell.cellIdentifier())
        listView.dataSource = self
        listView.delegate = self
        
        listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        
        //파이어베이스 연동
        
        self.view.addSubview(listView)
    }
    
}

extension PostListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListCell.cellIdentifier(), for: indexPath) as? PostListCell
        else {
            return UITableViewCell()
        }
         
        let post = viewModel.posts[indexPath.row]
            
        cell.setData(post: post)
            
        return cell
    }
}

extension PostListViewController : UITableViewDelegate
{
    
}


class PostListCell : UITableViewCell {

    static func cellIdentifier() -> String
    {
        return "PostListCell"
    }
    
    func setData(post : Post) {
        
    }
}

