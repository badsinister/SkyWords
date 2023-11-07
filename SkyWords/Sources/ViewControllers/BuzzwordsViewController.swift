/**
 
 BuzzwordsViewController
 
 Переводы. Листание страниц между вариантами перевода.
 
 */
import UIKit

class BuzzwordsViewController: UIPageViewController {

    /**
     Создание контроллера просмотра переводов для слова Part
     */
    static func instantiate(with part: Part) -> UIViewController {
        let buzzwordsViewController = BuzzwordsViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        buzzwordsViewController.context = BuzzwordsDataContext(with: part)
        return buzzwordsViewController
    }
    
    /// Контекст данных
    var context: BuzzwordsDataContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "...".localized
        navigationController?.navigationBar.prefersLargeTitles = true
        context.fetch { [weak self] (succes) in
            self?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
    }

    func reloadData () {
        title = context.title
        let buzzword = context.buzzword(at: 0)
        let viewController = BuzzwordViewController.instantiate(with: BuzzwordModelController(with: buzzword), at: 0)
        dataSource = nil
        setViewControllers([viewController], direction: .forward, animated: false, completion: nil)
        dataSource = self
    }

}

extension BuzzwordsViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let buzzwordViewController = viewController as? BuzzwordViewController else {
            fatalError()
        }
        let index = context.index(before: buzzwordViewController.index)
        let buzzword = context.buzzword(at: index)
        return BuzzwordViewController.instantiate(with: BuzzwordModelController(with: buzzword), at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let buzzwordViewController = viewController as? BuzzwordViewController else {
            fatalError()
        }
        let index = context.index(after: buzzwordViewController.index)
        let buzzword = context.buzzword(at: index)
        return BuzzwordViewController.instantiate(with: BuzzwordModelController(with: buzzword), at: index)
    }

}
