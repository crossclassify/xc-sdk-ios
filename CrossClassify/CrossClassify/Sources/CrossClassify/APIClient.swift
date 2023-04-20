import Foundation

struct FormData: Codable {
    let mock: String
}

class ApiClient {
    private let session = URLSession.shared
    private let baseURL = URL(string: CrossClassify.baseUrl)!
    private let cache = UserDefaults.standard
    
    // Key to access the cached data in UserDefaults
    private let cacheKey = "cachedFormData"
    
    func fetchFormData(completion: @escaping (Result<FormData, Error>) -> Void) {
        if let cachedData = cache.object(forKey: cacheKey) as? Data {
            do {
                let formData = try JSONDecoder().decode(FormData.self, from: cachedData)
                completion(.success(formData))
            } catch {
                completion(.failure(error))
            }
        } else {
            let request = URLRequest(url: baseURL)
            let task = session.dataTask(with: request) { [weak self] data, response, error in
                guard let strongSelf = self else { return }
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let formData = try JSONDecoder().decode(FormData.self, from: data)
                        strongSelf.cache.set(data, forKey: strongSelf.cacheKey)
                        completion(.success(formData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    }
}
