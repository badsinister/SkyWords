/**
 
 Работа с сетью. Создание модели из сетевых данных
 
 */

import Foundation
import NetWorker

extension Part {

    init(with anyPart: AnyPart) {
        self.identifier = anyPart.identifier
        self.text = anyPart.text
        var allMmeanings = [Meaning]()
        anyPart.meanings.forEach {
            let meaning = Meaning(with: $0)
            allMmeanings.append(meaning)
        }
        self.meanings = allMmeanings
    }

}
