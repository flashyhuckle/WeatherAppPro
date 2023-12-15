import Foundation

struct RequestPerformerPro {
    func performRequest<A: Decodable, B: Equatable>(
        url: URL,
        fromType: A.Type,
        toType: B.Type,
        castMethod: @escaping ((A) -> B),
        onCompletion: @escaping ((Result<B, Error>) -> Void)
    ) {
        URLSession.shared.request(
            with: url
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(fromType, from: data)
                    let castData = castMethod(decodedData)
                    onCompletion(.success(castData))
                } catch {
//                    throw HTTPRequestErrorPro.cannotDecodeData(from: data)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    onCompletion(.failure(error))
                }
            }
        }
    }
}
