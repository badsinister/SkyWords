/**
 
 MediaStore
 
 Управление ресурсами.
 
 */

import UIKit
import NetWorker

class MediaStore {
    
    static func image(at url: URL, _ completion: (UIImage?) -> Void) {
        print("load image at \(url.absoluteString)")
        completion(nil)
    }
    
}
