//
//  WriteViewController.swift
//  yourssu-Memo
//
//  Created by qualson1 on 2022/10/06.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class WriteViewController: UIViewController {
    
    var writeView = WriteView()
    
    let realm = try! Realm()
    
    var memoTask: Memo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.tertiarySystemGroupedBackground
        
        writeView.memoTextView.text = self.memoTask?.content
        
        self.view.addSubview(writeView)
        
        writeView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        self.navigationController?.navigationBar.tintColor = .systemOrange
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveMemoData()
    }
    
    func saveMemoData() {
        let currentDate = Date()
        
        if !writeView.memoTextView.text.isEmpty {
            
            let title = writeView.memoTextView.text.split(separator: "\n", maxSplits: 1).map(String.init)[0]
            
            if self.memoTask?._id != nil {
                try! realm.write {
                    self.memoTask?.title = title
                    self.memoTask?.content = writeView.memoTextView.text
                    self.memoTask?.createdDate = currentDate
                    self.memoTask?.updatedDate = currentDate
                }
            } else {
                let saveContent = Memo(title: title, content: writeView.memoTextView.text, createdDate: currentDate, updatedDate: currentDate)
                try! realm.write {
                    realm.add(saveContent)
                }
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
        
extension WriteViewController {
    
    func setNavigationBar() {
        configureNavigation()
        configureNavigationButton()
        configureToolBar()
    }
    
    func configureNavigation() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    func configureNavigationButton() {
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "완료", style: .plain, target: self, action:.none),
            UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: .none)]
    }
    
    func configureToolBar() {
        self.navigationController?.isToolbarHidden = true
    }
}
