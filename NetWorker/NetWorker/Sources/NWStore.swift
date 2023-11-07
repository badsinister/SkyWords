/**

 Сетевое хранилище
 
 Обеспечивает доступ к данным в сети.
 
 Иницилизация:
 
 Для конструктора без параметров используется URLSessionConfiguration.default
 
 */

import Foundation

public protocol NWSearchStore {
    
    func search(text: String, _ completion: @escaping (Result<[AnyPart], NWError>) -> Void)
    
}

public protocol NWBuzzwordStore {
    
    func buzzwords(with identifiers: [Int], _ completion: @escaping (Result<[AnyBuzzword], NWError>) -> Void)
    
    func media(with url: URL, _ completion: @escaping (Result<[AnyBuzzword], NWError>) -> Void)
    
}

public typealias NWStoreProtocol = NWSearchStore & NWBuzzwordStore

public class NWStore: NWStoreProtocol {
    
    private let manager: NWManager
    
    public init() {
        self.manager = NWManager()
    }
    
    /** Поиск */
    public func search(text: String, _ completion: @escaping (Result<[AnyPart], NWError>) -> Void) {
        manager.cancel()
        manager.load(url: NWResource.search(text).url) { (result: Result<[AnyPart], NWError>) in
            switch result {
            case .success(let anyParts):
                completion(.success(anyParts))
            case .failure(let error):
                switch error {
                case .cancellConnection:
                    // Зngапрос был отменен
                    return
                default:
                    completion(.failure(error))
                }
            }
        }
    }
    
    /** Слово */
    public func buzzwords(with identifiers: [Int], _ completion: @escaping (Result<[AnyBuzzword], NWError>) -> Void) {
        manager.load(url: NWResource.buzzwords(identifiers).url) { (result: Result<[AnyBuzzword], NWError>) in
            completion(result)
        }
    }
    
    /** Медиафайл */
    public func media(with url: URL, _ completion: @escaping (Result<[AnyBuzzword], NWError>) -> Void) {
        
    }

}
