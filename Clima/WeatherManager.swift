import Foundation

struct WeatherManager{
    
    var weatherURL:String?
    mutating func fetchWeather(cityName: String){
        self.weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=45e422329edc89219feb731651bb6a40&unit=metrics"
        
        performRequest(weatherURL: self.weatherURL!)
    }
    
    func performRequest(weatherURL: String){
        //1. Create URL
        if let url = URL(string: self.weatherURL!){
        //2.URL Session
        let session = URLSession(configuration: .default)
        //3.Give the session a task
        let task = session.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
        //4.Start The Task
        task.resume()
            
        }
    }
}
