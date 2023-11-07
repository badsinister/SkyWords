/**
 
 Контроллер модели.
 
 */

import Foundation

class PartModelController {

    fileprivate let part: Part
    
    init(with part: Part) {
        self.part = part
    }

}

extension PartModelController {

    var title: String {
        return part.text
    }
    
    var meaningsString: String {
        let meanings = part.meanings.compactMap({ $0.translation })
        return meanings.joined(separator: ", ")
    }

}
