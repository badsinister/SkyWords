/**
 
 DataStore
 
 Хранилище данных.
 
 Запрос данных контроллерами, загрузка, кеширование и тд.
 
 */

import Foundation
import NetWorker

/// Ошибки генерируемые хранилищем данных
enum DataStoreError: LocalizedError {
    /// Ошибка при запросе данных для поиска из сети
    case wrongSearch
    /// Неверный идентификатор
    case invalidIdentifier
    /// Слово по заданному идентификатору не найдено
    case buzzwordNotFound

    var localizedDescription: String {
        switch self {
        case .wrongSearch: return "Fetch Search Data Error".localized
        case .invalidIdentifier: return "Invalid Identifier".localized
        case .buzzwordNotFound: return "Buzzword Not Found".localized
        }
    }
}

/// Поиск
protocol PartDataStoreProtocol {

    /**
     Поиск переводов Part по слову text.
     
     - parameter text: Слово для которого осуществляется поиск.
     - parameter completion: Результаты поиска [Part] - массив слов (переводов) или DataStoreError - сообщение об ошибке.
     */
    func search(with text: String?, _ completion: @escaping (Result<[Part], DataStoreError>) -> Void)

}

/// Просмотр информации по слову
protocol BuzzwordDataStoreProtocol {

    /**
     Информация по слову.
     
     - parameter part: Слово для которого извлекаются значения.
     - parameter completion: Слова [BuzzWord]
     */
    func buzzwords(with part: Part, _ completion: @escaping (Result<[Buzzword], DataStoreError>) -> Void)
    
}

class DataStore {
    
    /// Доступ к данным в сети
    let netStore: NWStoreProtocol
    
    init() {
        self.netStore = NWStore()
    }

}

extension DataStore: PartDataStoreProtocol {

    func search(with text: String?, _ completion: @escaping (Result<[Part], DataStoreError>) -> Void) {
        guard let searchText = text, !searchText.isEmpty else {
            completion(.success([]))
            return
        }
        netStore.search(text: searchText) { (result: Result<[AnyPart], NWError>) in
            switch result {
            case .success(let anyParts):
                var parts = [Part]()
                anyParts.forEach {
                    let part = Part(with: $0)
                    parts.append(part)
                }
                completion(.success(parts))
            case .failure(let error):
                print(error)
                completion(.failure(.wrongSearch))
            }
        }
    }

}

extension DataStore: BuzzwordDataStoreProtocol {

    func buzzwords(with part: Part, _ completion: @escaping (Result<[Buzzword], DataStoreError>) -> Void) {
        let identifiers = part.meanings.map { $0.identifier }
        netStore.buzzwords(with: identifiers) { (result: Result<[AnyBuzzword], NWError>) in
            switch result {
            case .success(let anyBuzzwords):
                let buzzwords = anyBuzzwords.map { Buzzword(with: $0) }
                completion(.success(buzzwords))
            case .failure(let error):
                print(error)
                completion(.failure(.buzzwordNotFound))
            }
        }
    }

}
