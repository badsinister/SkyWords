/**
 
 
 
 */

import UIKit

final class WordTableViewCellModel {
    
    class func setup(_ cell: WordTableViewCell, with partModelController: PartModelController) {
        cell.titleLabel.text = partModelController.title
        cell.meaningsLabel.text = partModelController.meaningsString
    }
    
    class func registerCell(for tableView: UITableView) {
        //tableView.register(UINib(nibName: WordTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: WordTableViewCell.identifier)
    }
    
}
