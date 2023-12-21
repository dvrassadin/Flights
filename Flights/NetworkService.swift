//
//  NetworkService.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import Foundation

protocol NetworkService {
    func getFlight(_ type: FlightsType) async throws -> [Flight]
}

enum NetworkError: Error {
    case invalidURL, noData, invalidData
}

final class YandexNetworkService: NetworkService {
    private let baseURL = "https://api.rasp.yandex.net/v3.0/schedule"
    
    func getFlight(_ type: FlightsType) async throws -> [Flight] {
        guard var url = URL(string: baseURL) else { throw NetworkError.invalidURL }
        
        url.append(queryItems: [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "station", value: "LED"),
            URLQueryItem(name: "lang", value: "ru_RU"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "date", value: "2023-12-21"),
            URLQueryItem(name: "system", value: "iata"),
            
        ])
        
        switch type {
        case .arrivals:
            url.append(queryItems: [URLQueryItem(name: "event", value: "arrival")])
        case .departures:
            url.append(queryItems: [URLQueryItem(name: "event", value: "departure")])
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noData
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        guard let flights = try? decoder.decode(YandexResponse.self, from: data).schedule else {
            throw NetworkError.invalidData
        }
        
        return flights
    }
}
