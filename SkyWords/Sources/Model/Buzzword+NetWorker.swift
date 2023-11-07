/**
 
 Работа с сетью. Создание модели из сетевых данных
 
 */

import Foundation
import NetWorker

extension Buzzword {
    
    init(with anyBuzzword: AnyBuzzword) {
        self.identifier = anyBuzzword.identifier
        self.text = anyBuzzword.text
        self.translation = anyBuzzword.translation.text
        self.note = anyBuzzword.translation.note
        self.transcription = anyBuzzword.transcription
        self.soundUrl = URL(string: anyBuzzword.sound)
        var images = [URL]()
        anyBuzzword.images.forEach {
            for (_, url) in $0 {
                if let url = URL(string: url) {
                    images.append(url)
                }
            }
        }
        self.images = images
    }
    
}
