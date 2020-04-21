import Foundation

struct WeatherManager{
    
    var weatherURL:String?
    mutating func fetchWeather(cityName: String){
        self.weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=45e422329edc89219feb731651bb6a40&units=metric"
        
        performRequest(weatherURL: self.weatherURL!)
    }
    
    func performRequest(weatherURL: String){
        //1. Create URL
        if let url = URL(string: self.weatherURL!){
            //2.URL Session
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) {
                (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            //4.Start The Task
            task.resume()
            
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
          let decodedData =   try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        }catch {
            print(error)
        }
    }
    
}
