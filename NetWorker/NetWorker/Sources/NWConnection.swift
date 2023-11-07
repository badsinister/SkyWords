/**
 
 NWConnection
 
 Организация сетевого соединения
 
 */

import Foundation

class NWConnection {

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    /** Текущая сессия */
    private let session: URLSession

    /** Активные задачи */
    private var tasks: Set<URLSessionDataTask>

    init(with configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
        self.tasks = Set<URLSessionDataTask>()
    }

    /** Сетевой запрос */
    @discardableResult
    func request(url: URL, completion: @escaping CompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: url, completionHandler: completion)
        task.resume()
        tasks.insert(task)
        return task
    }

    /** Очищение списка текущих задач */
    func cancel() {
        tasks.forEach {
            $0.cancel()
        }
        tasks.removeAll()
    }

}
