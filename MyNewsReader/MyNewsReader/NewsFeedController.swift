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
        super.viewDidLoad()
        presenter = Presenter()
        presenter?.controller = self
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

struct ErrorViewModel {
    let title: String
    let description: String
    let actionTitle: String
    var actionHandler: ((UIAlertAction) -> Void)?
}

class ErrorView {
        
    static func presentError(on controller: UIViewController?, withData data: ErrorViewModel) {
        
        let error = UIAlertController(title: data.title, message: data.description, preferredStyle: .alert)
        error.addAction(UIAlertAction(title: data.actionTitle,
                                      style: .default,
                                      handler: data.actionHandler))
        DispatchQueue.main.async {
            controller?.present(error, animated: true) {
                
            }
        }
    }
    
}
