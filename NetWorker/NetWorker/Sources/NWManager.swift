/**
 
 NWManager
 
 Организация работы с сетью
 Запрос и декодирование данных. Формирование ошибок.
 
 */

import Foundation

class NWManager {

    private let configuration: URLSessionConfiguration

    /** Имя списка задач по умолчанию */
    static let DefaultConnectionQueue = "DefaultConnectionQueue"

    /** Список активных соединений */
    private var connections: [String: NWConnection]

    init(configuration: URLSessionConfiguration = .default) {
        self.configuration = configuration
        self.connections = [NWManager.DefaultConnectionQueue: NWConnection(with: configuration)]
    }

    /** Возвращает соединение для идентификатора queue. Если нет соединения - создается новое,
     с добавлением в connections.
     - parameter queue: Идентификатор соединения
     - returns: Соединение
     */
    func connector(from queue: String) -> NWConnection {
        if let connection = connections[queue] {
            return connection
        }
        let connection = NWConnection(with: configuration)
        connections[queue] = connection
        return connection
    }

    /** Возвращает соединение для идентификатора queue. Если нет соединения - создается новое,
     с добавлением в connections.
     - parameter url: Адрес ресурса
     - parameter queue: Идентификатор коннектора
     - returns: Соединение
     */
    func load<T: Decodable>(url: URL?, queue: String = DefaultConnectionQueue, completion: @escaping (Result<[T], NWError>) -> Void) {
        guard let requestUrl = url else {
            completion(.failure(.cannotCreateURL(url?.absoluteString ?? "none")))
            return
        }
        let connection = connector(from: queue)
        connection.request(url: requestUrl) { (data, response, error) in
            if let error = error as NSError? {
                switch error.code {
                case -1009:
                    completion(.failure(.noInternetConnection))
                case -999:
                    completion(.failure(.cancellConnection))
                default:
                    completion(.failure(.wrongConnection(error.localizedDescription)))
                }
            } else if let data = data {
                // Обработка полученных данных
                do {
                    //print("\(try! JSONSerialization.jsonObject(with: data, options: .allowFragments))")
                    let model = try JSONDecoder().decode([T].self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(.decodeError))
                }
            } else {
                completion(.failure(.requestError))
            }
        }
    }

    /** Удаление заданий для соединения с идентификатором queue.
     - parameter queue: Идентификатор коннектора
     */
    func cancel(queue: String = DefaultConnectionQueue) {
        let connection = connector(from: queue)
        connection.cancel()
    }

}
