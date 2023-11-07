/**
 
 Работа с сетью. Создание модели из сетевых данных
 
 */

import Foundation
import NetWorker

extension Meaning {

    init(with anyMeaning: AnyMeaning) {
        self.identifier = anyMeaning.identifier
        self.translation = anyMeaning.translation.text
        self.note = anyMeaning.translation.note
        self.transcription = anyMeaning.transcription
        self.preview = URL(string: anyMeaning.preview)
        self.sound = URL(string: anyMeaning.sound)
    }

}
