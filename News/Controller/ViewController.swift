//
//  ViewController.swift
//  News
//
//  Created by Никита Коголенок on 21.03.22.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    // MARK: - Variable
    public var viewModels = [NewsTableViewCellViewModel]()
    public var articles = [Article]()
    
    // MARK: - GUI Variables
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        return table
    }()

    // MARK: - View Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creadDelegateAndOther()
        fetchTopStories()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Method
    private func creadDelegateAndOther() {
        title = "News"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchTopStories() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               subtitle: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

