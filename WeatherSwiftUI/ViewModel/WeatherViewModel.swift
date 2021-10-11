import Foundation


class WeatherViewModel {
    
    var cityName: String = "Boston"
    var listOfHourlyForecasts: [List] = []
    
    var listOfDays: [Day] = []
    
    func turnResponseIntoDayObjects() {
        
        // the number of objects in listOfHourlyForecasts will always be 40
        // Each 8 objects of List will be a single day
        // indices 0-7 will be day 1, 8-15 day 2 and so forth
        
        var offset = 0
        
        
        for _ in 0...4 {
            self.listOfDays.append(collectADay(list: self.listOfHourlyForecasts, offset: offset))
            offset += 8
        }
        
        
    }
    
    func collectADay(list: [List], offset: Int) -> Day {
        var listOfForecasts: [List] = []
        
        for i in offset..<list.count {
            listOfForecasts.append(list[i])
        }
        return Day(hourForecasts: listOfForecasts)
    }
    
    func getForecast(city: String, completion: @escaping () -> Void) {
        
        listOfDays = []
        
        APIRouter.shared.getWeatherData(city: city, completion: { result in
            switch result {
            case .success(let weatherReponse):
                self.listOfHourlyForecasts = weatherReponse.list
                completion()
                
                
            case .failure(let error):
                print(error)
                completion()
            }
        })
    }
}
