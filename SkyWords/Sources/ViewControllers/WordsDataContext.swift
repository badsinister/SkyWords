/**
 
 WordsDataContext
 Контекст данных
 
 */

import UIKit

class WordsDataContext {
    
    var model: [Part]
    
    /** Хранилище данных */
    lazy var dataStore: PartDataStoreProtocol = DataStore()
    
    /// Название контекста
    var title: String? {
        return "SkyWords".localized
    }
    
    init() {
        self.model = [Part]()
    }
    
    func fetch(text: String?, _ completion: @escaping (Bool) -> Void) {
        dataStore.search(with: text) { (result: Result<[Part], DataStoreError>) in
            switch result {
            case .success(let parts):
                DispatchQueue.main.async {
                    self.model = parts
                    completion(true)
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
}

extension WordsDataContext {
    
    static func registerCells(for tableView: UITableView) {
        WordTableViewCellModel.registerCell(for: tableView)
    }
    
    func numberOfSections(for tableView: UITableView) -> Int {
        return 1
    }
    
    func numberOfRows(for tableView: UITableView, in section: Int) -> Int {
        return model.count
    }
    
    func dequeueReusableCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WordTableViewCell.identifier, for: indexPath) as? WordTableViewCell else {
            fatalError()
        }
        WordTableViewCellModel.setup(cell, with: PartModelController(with: model[indexPath.row]))
        return cell
    }

    func didSelect(for tableView: UITableView, in viewController: UIViewController, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let buzzwordsViewController = BuzzwordsViewController.instantiate(with: model[indexPath.row])
        viewController.navigationController?.pushViewController(buzzwordsViewController, animated: true)
    }
    
}
