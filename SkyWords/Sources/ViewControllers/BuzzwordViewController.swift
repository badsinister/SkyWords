/**
 
 BuzzwordViewController
 Перевод
 
 */

import UIKit

class BuzzwordViewController: UIViewController {

    static func instantiate(with modelController: BuzzwordModelController, at index: Int) -> UIViewController {
        guard let buzzwordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "BuzzwordViewController") as? BuzzwordViewController else {
            fatalError("BuzzwordViewController not found")
        }
        buzzwordViewController.buzzwordModelController = modelController
        buzzwordViewController.index = index
        return buzzwordViewController
    }

    @IBOutlet fileprivate var imageView: UIImageView!

    @IBOutlet fileprivate var translationLabel: UILabel!

    var buzzwordModelController: BuzzwordModelController!

    var index: Int!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        translationLabel.text = buzzwordModelController.translation
        buzzwordModelController.image { [weak self] (image) in
            self?.imageView.image = image
        }
    }

}
