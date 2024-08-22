//
//  PostDetailViewController.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/17/24.
//

import UIKit

class PostDetailViewController: UIViewController {

    var viewModel : PostDetailViewModel
    
    var textView : UITextView!
    
    init(viewModel: PostDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextView()
        self.setupConstraint()
        
        self.textView.text = self.viewModel.post.contents
    }
    
    func setupTextView() {
        let textView = UITextView(frame: .zero)
        textView.translatesAutoresizingMaskIntoConstraints = false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
