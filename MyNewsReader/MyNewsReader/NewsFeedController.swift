//
//  NewsFeedController.swift
//  MyNewsReader
//
//  Created by Himanshu T on 15/4/21.
//

import UIKit

class NewsFeedController: UITableViewController {
    
    var presenter: Presenter!
    
    override func viewDidLoad() {
        presenter = Presenter()
        presenter?.controller = self

        super.viewDidLoad()
        
        presenter?.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.numberOfArticles else { return 0 }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: NewsItemCellView = tableView.dequeueReusableCell(withIdentifier: presenter!.identifierForNewsItemCell(for: indexPath), for: indexPath) as! NewsItemCellView

        if let data = presenter?.articleForIndexPath(indexPath) {
            cell.populate(withArticle: data)
        }
        
        return cell
    }

}
