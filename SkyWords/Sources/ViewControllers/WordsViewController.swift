
import UIKit
import NetWorker

class WordsViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView! {
        didSet {
            WordsDataContext.registerCells(for: tableView)
            tableView.tableFooterView = UIView()
        }
    }

    // MARK: -
    
    // Контекст данных
    lazy var context: WordsDataContext = WordsDataContext()
    
    // Поисковый контроллер со строкой поиска
    var searchController: UISearchController!
    
    // Контроллер отображения результатов
    var resultsTableViewController: UITableViewController!
     
    // MARK: -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = context.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Поисковый контроллер
        searchController = UISearchController(searchResultsController: nil)
        // Уедомления для UISearchToken
        searchController.searchResultsUpdater = self

        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.searchTextField.placeholder = "Ваше слово, товарищ маузер"
        searchController.searchBar.returnKeyType = .search

        searchController.obscuresBackgroundDuringPresentation = false

        // Добавим поисковую строку и сделаем всегда видимой
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
}

extension WordsViewController: UISearchResultsUpdating {

    /** Изменение в поисковом контроллере - изменено слова поиска */
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        context.fetch(text: searchText) { [weak self] (success) in
            if success {
                self?.reloadData()
            }
        }
    }

}

// MARK: - Табличное представление

extension WordsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return context.numberOfSections(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return context.numberOfRows(for: tableView, in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return context.dequeueReusableCell(for: tableView, at: indexPath)
    }
    
}

extension WordsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        context.didSelect(for: tableView, in: self, at: indexPath)
    }
    
}
