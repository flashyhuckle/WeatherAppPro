import Foundation

extension URLSession {
    typealias Handler = (Result<Data, Error>) -> Void

    @discardableResult
    func request(
        with url: URL,
        handler: @escaping Handler
    ) -> URLSessionDataTask {
        let task = dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else if let data = data {
                handler(.success(data))
            }
        }
        task.resume()
        return task
    }
}
