//
//  File.swift
//  iCount
//
//  Created by Ionut Ciovica on 30/10/2021.
//

import Foundation

protocol CoinManagerDelegate {
    func getLastPrice(_ coinManager: CoinManager, coin: Double)
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let secondURL = "?apikey="
    let apiKey = "BCD1FF16-8AC2-4666-B6B3-E4AAB67F2A34"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)\(secondURL)\(apiKey)"
        
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
                    if let bitcoinPrice = self.parseJSON(safeData) {
                        delegate?.getLastPrice(self, coin: bitcoinPrice)
                    }
                }
                
            }
            //Start task to fetch data from bitcoin average's servers.
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decodedData.rate
            
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
