import Foundation
import Alamofire



class APIRouter {
    
    static let shared: APIRouter = {
        let shared = APIRouter()
        
        return shared
    }()
    
    var apiKey: String
    var baseURL: URL //need this in scope of class for later building of api calls
    
    private init() {
        baseURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?")!
        apiKey = Constants.apiKey
    }
    
    func getWeatherData(city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        let getWeatherURL = "\(baseURL)q=\(city)&units=imperial&appid=\(apiKey)"
        
        AF.request(getWeatherURL)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: WeatherResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    print(error)
                    completion(.failure(error))
                }
            }
    }
}



