/**
 
 Слово. Полная информация.
 
 */

import Foundation

struct Buzzword {
    var identifier: Int
    var text: String
    var translation: String
    var note: String?
    var transcription: String
    //var alternativeTranslations: [Tra]
    var soundUrl: URL?
    var images: [URL]?
}
