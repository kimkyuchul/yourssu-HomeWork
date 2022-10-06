//
//  WriteView.swift
//  yourssu-Memo
//
//  Created by qualson1 on 2022/10/06.
//

import UIKit
import SnapKit
import Then

class WriteView: UIView {
    
    let memoTextView = UITextView().then {
        $0.font = UIFont.systemFont(ofSize: 25)
        $0.translatesAutoresizingMaskIntoConstraints = true
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
        
        addSubview(memoTextView)
    }
    
    private func setConstraints() {
        memoTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
