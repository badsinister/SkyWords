/**
 
 NWError
 
 Ошибки
 
 */

import Foundation

/** Ошибки передаваемые системе */
public enum NWError: Error {
    /// Не удается создать URL - некорректное значения для адреса запроса. url - некорректный адрес.
    case cannotCreateURL(_ url: String)
    case noInternetConnection
    case wrongConnection(_ reason: String)
    case cancellConnection
    case decodeError
    case requestError
    /// Слово, запрошенное по идентификатору не найдено (на стороне сервера)
    case buzzwordsNotFound
}
