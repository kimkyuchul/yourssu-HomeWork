//
//  ListTableViewCell.swift
//  yourssu-Memo
//
//  Created by qualson1 on 2022/10/06.
//

import UIKit
import SnapKit
import Then

class ListTableViewCell: UITableViewCell {
    
    let title = UILabel().then{
        $0.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        contentView.addSubview(title)
    }
    
    private func setConstraints() {
        title.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
