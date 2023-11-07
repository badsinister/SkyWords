/**
 
 BuzzWordDataContext
 
 Контекст данных
 
 */

import Foundation

class BuzzwordsDataContext {
    
    fileprivate var part: Part
    
    fileprivate var model: [Buzzword]

    /** Хранилище данных */
    lazy var dataStore: BuzzwordDataStoreProtocol = DataStore()
    
    /// Название контекста
    var title: String? {
        return part.text
    }
    
    init(with part: Part) {
        self.part = part
        self.model = [Buzzword]()
    }

    func index(after index: Int) -> Int {
        if index < model.count - 1 {
            return index + 1
        }
        return 0
    }

    func index(before index: Int) -> Int {
        if index == 0 {
            return model.count - 1
        }
        return index - 1
    }

    func buzzword(at index: Int) -> Buzzword {
        return model[index]
    }

    func fetch(_ completion: @escaping (Bool) -> Void) {
        dataStore.buzzwords(with: part) { [weak self] (result: Result<[Buzzword], DataStoreError>) in
            switch result {
            case .success(let buzzwords):
                DispatchQueue.main.async {
                    self?.model = buzzwords
                    completion(true)
                }
            case .failure(let error):
                print("\(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }

}
