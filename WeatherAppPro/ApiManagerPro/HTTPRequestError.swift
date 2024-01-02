import Foundation

enum HTTPRequestErrorPro: Error {
    case cannotBuildValidURL(urlPath: String)
//    case cannotDecodeData(from: Data)
}
