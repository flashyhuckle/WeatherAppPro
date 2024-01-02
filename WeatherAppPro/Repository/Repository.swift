import Foundation

enum HTTPRequestError: Error {
    case cannotBuildValidURL(path: String, method: HTTPMethod)
}

enum DecodeError: Error {
    case cannotDecodeData
}

public enum HTTPMethod: String {
    case GET
    case POST
}

protocol EndpointType {
    var path: String { get }
    var method: HTTPMethod { get }
}


func decode<T: Decodable>(into type: T.Type, data: Data) throws -> T {
    try JSONDecoder().decode(type, from: data)
}


//struct HTTPRequest {
//    let url: URL
//    let method: HTTPMethod
//
//    init(
//        path: String,
//        method: HTTPMethod
//    ) throws {
//        guard let url = URL(string: path) else {
//            // 🚨 Handle base url
//            throw HTTPRequestError.cannotBuildValidURL(baseURLPath: path, path: path)
//        }
//
//        self.url = url
//        self.method = method
//    }
//}
