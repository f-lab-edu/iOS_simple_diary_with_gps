//
//  PostListViewController.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/8/24.
//

import UIKit
import Combine
import FirebaseCore
import FirebaseAuth

class PostListViewController: UIViewController {

    var viewModel : PostListViewModel = PostListViewModel(service: PostServiceImp())
    
    var addPostButton : UIButton!
    var listView : UITableView!
    
    var cancellable : Set<AnyCancellable> = Set()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAddPostButton()
        self.setupListView()
        
        Auth.auth().signInAnonymously { (authResult, error) in
            if let error = error {
                print("Authentication error: \(error.localizedDescription)")
                return
            }
        }

        viewModel.onEvent.sink { event in
            switch event {
            case .postUpdated :
                self.listView.reloadData()
            default :
                break
            }
        }.store(in: &cancellable)
        
        viewModel.loadPostList()
    }
    
    func setupAddPostButton() {
        let navigationItem = UIBarButtonItem(title: "add Post", image: nil, target: self, action: #selector(addButtonTapped))
        navigationController?.navigationBar.tintColor = .blue
        self.navigationItem.title = "PostList"
        self.navigationItem.setRightBarButton(navigationItem, animated: false)
    }
    
    func setupListView() {
        
        listView = UITableView()
        
        listView.register(PostListViewCell.self, forCellReuseIdentifier: PostListViewCell.cellIdentifier())
        listView.dataSource = self
        listView.delegate = self
        listView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(listView)
        
        NSLayoutConstraint.activate([
            listView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
    @IBAction func addButtonTapped() {
        self.viewModel.addPost(contents: "test")
    }
    
}

extension PostListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListViewCell.cellIdentifier(), for: indexPath) as? PostListViewCell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.viewModel.posts[indexPath.row]
        let detailViewModel = PostDetailViewModel(service: PostServiceImp(), post: post)
        let detailViewController = PostDetailViewController(viewModel: detailViewModel)
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            viewModel.removePost(post: viewModel.posts[indexPath.row])
        } else if editingStyle == .insert {
            
        }
    }
}

