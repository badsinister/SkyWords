/**
 
 Контроллер модели.
 
 */

import UIKit

class BuzzwordModelController {
    
    fileprivate let buzzword: Buzzword
    
    init(with buzzword: Buzzword) {
        self.buzzword = buzzword
    }

}

extension BuzzwordModelController {
    
    var translation: String {
        return buzzword.translation
    }
    
    func image(_ completion: (UIImage?) -> Void) {
        guard let url = buzzword.images?.first else {
            completion(nil)
            return
        }
        MediaStore.image(at: url) { (image) in
            completion(image)
        }
    }

}
