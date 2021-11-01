//
//  ExchangeManager.swift
//  iCount
//
//  Created by Ionut Ciovica on 01/11/2021.
//

import Foundation

protocol ExchangeManagerDelegate {
    func getLastPrice(_ coinManager: ExchangeManager, coin: Double)
    func didFailWithError(error: Error)
}

struct ExchangeManager {
    
    let baseURL = "http://api.exchangeratesapi.io/v1/latest?access_key=fce4add086159b87eed16e4d0986e97f&symbols&baseGBP"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: ExchangeManagerDelegate?
    
    func getCoinPrice(for currency: String, position: Int?) {
        let urlString = "\(baseURL)\(currency)"
        
        if let url = URL(string: urlString) {
            
            //Create a new URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            
            //Create a new data task for the URLSession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                //Format the data we got back as a string to be able to print it.
//                let dataAsString = String(data: data!, encoding: .utf8)
//                print(dataAsString!)
                if let safeData = data {
                    if let coinRate = self.parseJSON(safeData, position: position) {
                        delegate?.getLastPrice(self, coin: coinRate)
                    }
                }
                
            }
            //Start task to fetch data from bitcoin average's servers.
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data, position: Int?) -> Double? {
        let decoder = JSONDecoder()
        
        guard let position = position else {
            fatalError("Couldn't find the coin position in currencyArray.")
        }

        do {
            let decodedData = try decoder.decode(ExchangeData.self, from: data)
            
//            array.append(contentsOf: decodedData.rates.values)
            let lastPrice = decodedData.rates[currencyArray[position]]

            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
