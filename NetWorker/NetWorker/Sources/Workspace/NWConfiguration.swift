/**
 
 NWConfiguration
 
 Конфигурация сервера
 
 */

import Foundation

/** Адрес АПИ */
let API: String = "https://dictionary.skyeng.ru/api/public/v1"

/** Ресурсы сервера, к которым осуществляется запрос */
enum NWResource {
    case search(_ text: String)
    case buzzwords(_ identifiers: [Int])
}

/** Построение адресов запроса */
extension NWResource {
    var url: URL? {
        var path: String
        var queryItems: [URLQueryItem]
        switch self {
        case .search(let text):
            path = "/words/search"
            queryItems = [URLQueryItem(name: "search", value: text)]
        case .buzzwords(let identifiers):
            path = "/meanings"
            queryItems = [URLQueryItem(name: "ids", value: identifiers.map({ "\($0)" }).joined(separator: ", "))]
        }
        var components = URLComponents(string: API)
        components?.path += path
        components?.queryItems = queryItems
        return components?.url
    }
}
