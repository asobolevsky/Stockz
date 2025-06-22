import Foundation

extension HTTPURLResponse {
    static func mock(url: URL, statusCode: Int = 200) -> HTTPURLResponse {
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "1.1", headerFields: [:])!
    }
}
