//
//  NetworkService.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import Foundation

protocol NetworkService {
    
}

final class YandexNetworkService: NetworkService {
    private let baseURL = "https://api.rasp.yandex.net/v3.0/schedule/?apikey=" + apiKey
    
    func getFlight(_ type: FlightsType) {
        
    }
}
