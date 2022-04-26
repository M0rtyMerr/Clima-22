//


import UIKit

final class WeatherViewController: UIViewController {
    
    @IBOutlet private var conditionImageView: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var searchTextField: UITextField!

    private var weatherManager = WeatherManager()
    
    @IBAction private func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {return true} else {textField.placeholder="Печатай еще сучка"
            return false}
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use search field to check weather
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        textField.text=""
    }
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager:WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text=weather.temperatureString
            self.cityLabel.text=weather.cityName
            self.conditionImageView.image=UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
