//
//  ListViewController.swift
//  yourssu-Memo
//
//  Created by qualson1 on 2022/10/06.
//

import UIKit
import SnapKit
import Then
import RealmSwift

class ListViewController: UIViewController {
    
    let realm = try! Realm()
    
    var tasks: Results<Memo>!
    
    var listView = ListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(listView)
        
        listView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        tasks = realm.objects(Memo.self)
        listView.listTableview.reloadData()
    }
    
    func setUpTableView() {
        listView.listTableview.delegate = self
        listView.listTableview.dataSource = self
        
        listView.listTableview.register(ListTableViewCell.classForCoder(), forCellReuseIdentifier: "ListTableViewCell")
        }
    
    @objc func writeBtnTap() {
        let newViewController = WriteViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension ListViewController {
    func setNavigationBar() {
        configureNavigationTitle()
        configureNavigationButton()
        configureNavigationsearchBar()
        configureToolBar()
    }
        
    func configureNavigationTitle() {
        self.title = "yourSSU 메모"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        
        // 네비게이션바 색상 변경 코드가 안먹음..
        appearance.backgroundColor = UIColor.tertiarySystemGroupedBackground
        appearance.configureWithOpaqueBackground()
        
        appearance.titleTextAttributes =
            [
            .foregroundColor : UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: 20)
            ]
        
        appearance.largeTitleTextAttributes =
            [
            .foregroundColor : UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: 40)
            ]
        
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func configureNavigationButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(systemName:"ellipsis.circle"), style: .plain, target: self, action:nil)
        self.navigationItem.rightBarButtonItem?.tintColor =  UIColor.systemOrange
    }
    
    func configureNavigationsearchBar() {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchBar
    }
    
    func configureToolBar() {
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor.tertiarySystemGroupedBackground
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let writeButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(writeBtnTap))
        writeButtonItem.tintColor = .systemOrange
        
        self.toolbarItems = [space, writeButtonItem]
    }
    
}


extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listView.listTableview.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell

        cell.title.text = tasks?[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = WriteViewController()
        let memo = tasks[indexPath.row]
        newViewController.memoTask = memo
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "삭제") { action, view, success in
            let memo = self.tasks[indexPath.row]
            
            try! self.realm.write {
                self.realm.delete(memo)
            }
            self.listView.listTableview.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
       return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 15))
        return headerView
    }
}
