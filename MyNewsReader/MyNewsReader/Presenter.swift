//
//  Presenter.swift
//  MyNewsReader
//
//  Created by Himanshu T on 14/4/21.
//

import UIKit

class Presenter {
    
    weak var controller : NewsFeedController?
    var interactor: Interactor?
    
    init() {
        self.interactor = Interactor()
    }
    
    var articles = [NewsItem]() {
        didSet {
            DispatchQueue.main.async {
                self.controller?.tableView.reloadData()
            }
        }
    }
    
    var numberOfArticles: Int {
        articles.count
    }
    
    func viewDidLoad() {
        interactor?.getArticles(handler: { result in
            switch result {
            case .failure(let err):
                self.handleError(err)
            case .success(let articlesArray):
                self.articles = articlesArray
            }
        })
    }
    
    private func handleError(_ err:Error) {
        let errorModel = ErrorViewModel(title: "Error Fetching Articles", description: err.localizedDescription, actionTitle: "Ok") { alertAction in
            print(err)
        }
        ErrorView.presentError(on: controller, withData: errorModel)
    }
    
    func identifierForNewsItemCell(for indexPath: IndexPath) -> String {
        switch indexPath.row {
        case 0:
            return "newsItemLarge"
        default:
            return "newsItemSmall"
        }
    }
    
    func articleForIndexPath(_ indexPath:IndexPath) -> NewsItemCellViewModel {
        let item = articles[indexPath.row]
        return NewsItemCellViewModel(imageUrl: imageUrlForIndexPath(indexPath), titleText: item.title, dateText: publishedDateForArticle(indexPath))
    }
    
    private func publishedDateForArticle(_ indexPath:IndexPath) -> NSAttributedString {
        let item = articles[indexPath.row]
        let df = DateFormatter.designedDateFormatter()
        let date = df.string(from: item.pubDate.toDate()!)
        let string = NSMutableAttributedString(string: date)
        string.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 13), range: NSRange(location: 0, length: 11))
        return NSAttributedString(attributedString: string)
    }
    
    private func imageUrlForIndexPath(_ indexPath:IndexPath) -> URL {
        let item = articles[indexPath.row]
        switch indexPath.row {
        case 0:
            return item.enclosure.thumbnail
        default:
            return item.thumbnail
        }
    }
}
