import Foundation
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager{
    
    var weatherURL:String?
    var delegate:WeatherManagerDelegate?
    mutating func fetchWeather(cityName: String){
        self.weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=45e422329edc89219feb731651bb6a40&units=metric"
        
        performRequest(with: self.weatherURL!)
    }
    
    
    func performRequest(with weatherURL: String){
        //1. Create URL
        if let url = URL(string: self.weatherURL!){
            //2.URL Session
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil{
                    
                    print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            //4.Start The Task
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData =   try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            
            let weather:WeatherModel = WeatherModel(conditionID: id, cityName: name, temperature: Double(temp))
            return weather
        }catch {
            print(error)
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    
    
    
    
    
}
