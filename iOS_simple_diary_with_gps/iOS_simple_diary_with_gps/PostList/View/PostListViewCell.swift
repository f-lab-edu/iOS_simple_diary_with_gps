//
//  PostListViewCell.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/15/24.
//

import UIKit

class PostListViewCell: UITableViewCell {
    
    var contentsLabel : UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentsLabel()
        setupConstraints()
    }
    
    func setupContentsLabel() {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentsLabel = label
        self.contentView.addSubview(label)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate(
        [
            contentsLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            contentsLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor , constant: 0),
            contentsLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: 0),
            contentsLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor , constant: 0)
        ])
    }
    
    static func cellIdentifier() -> String
    {
        return "PostListCell"
    }
    
    func setData(post : Post) {
        self.contentsLabel.text = post.contents
    }
    
}
