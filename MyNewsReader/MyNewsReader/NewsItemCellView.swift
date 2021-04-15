//
//  NewsItemCellView.swift
//  MyNewsReader
//
//  Created by Himanshu T on 15/4/21.
//

import UIKit

struct NewsItemCellViewModel {
    let imageUrl: URL
    let titleText: String
    let dateText: NSAttributedString
}

class NewsItemCellView: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        
    }
}

extension NewsItemCellView {
    func populate(withArticle item: NewsItemCellViewModel) {
        self.titleLabel.text = item.titleText
//        self.itemImageView.sd_setImage(with: item.imageUrl, placeholderImage: nil)
        self.dateLabel.attributedText = item.dateText
    }
}
