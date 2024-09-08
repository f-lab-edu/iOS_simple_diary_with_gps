//
//  PostWritingViewController.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 9/4/24.
//

import UIKit
import Combine

class PostWritingViewController: UIViewController {

    var viewModel : PostWriteViewModel
    var cancellable : Set<AnyCancellable> = Set()
    
    var textView : UITextView!
    var addPostButton : UIButton!
    
    init(viewModel: PostWriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupTextView()
        self.setupCloseButton()
        self.setupAddPostButton()
        self.setupConstraint()
        
        self.textView.text = self.viewModel.post?.contents
        
        viewModel.onEvent.sink { event in
            switch event {
            case .postAdded(let error) :
                
                if let error = error {
                    let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "확인", style: .default) { action in
                        alert.dismiss(animated: true)
                    }
                    alert.addAction(confirmAction)
                    self.present(alert, animated: true)
                }
                else
                {
                    let alert = UIAlertController(title: "게시글이 추가되었습니다.", message: nil, preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "확인", style: .default) { action in
                        alert.dismiss(animated: true)
                        self.dismiss(animated: true)
                    }
                    alert.addAction(confirmAction)
                    self.present(alert, animated: true)
                }
            default :
                break
            }
        }.store(in: &cancellable)
        
        
    }
    
    func setupAddPostButton() {
        let navigationItem = UIBarButtonItem(title: "add Post", image: nil, target: self, action: #selector(addButtonTapped))
        navigationController?.navigationBar.tintColor = .blue
        self.navigationItem.title = "Write Post"
        self.navigationItem.setRightBarButton(navigationItem, animated: false)
    }
    
    func setupCloseButton() {
        let navigationItem = UIBarButtonItem(title: "close", image: nil, target: self, action: #selector(closeButtonTapped))
        navigationController?.navigationBar.tintColor = .blue
        self.navigationItem.setLeftBarButton(navigationItem, animated: false)
    }
    
    func setupTextView() {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = true
        self.textView = textView
        self.view.addSubview(self.textView)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate(
        [
            textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }

    @IBAction func addButtonTapped() {
        self.viewModel.addPost(contents: self.textView.text)
    }
    
    @IBAction func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
