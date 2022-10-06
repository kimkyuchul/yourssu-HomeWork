//
//  ListView.swift
//  yourssu-Memo
//
//  Created by qualson1 on 2022/10/06.
//

import UIKit
import SnapKit
import Then

class ListView: UIView {
    
    var listTableview = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.tertiarySystemGroupedBackground
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewHierarchy()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHierarchy() {
        addSubview(listTableview)
    }
    
    private func setConstraints() {
        listTableview.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
}
