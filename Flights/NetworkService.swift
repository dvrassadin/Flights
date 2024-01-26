//
//  NetworkService.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import Foundation

protocol NetworkService {
    func getFlight(_ type: FlightsType, date: Date, airportIATACode: String) async throws -> [Flight]
    func getCopyright() async throws -> Copyright
}

enum NetworkError: Error {
    case invalidURL, emptyData
}

final class YandexNetworkService: NetworkService {
    private let baseURL = "https://api.rasp.yandex.net/v3.0"
    private let session = URLSession.shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func getFlight(_ type: FlightsType, date: Date, airportIATACode: String) async throws -> [Flight] {
        guard var url = URL(string: baseURL) else { throw NetworkError.invalidURL }
        
        url.append(path: "schedule")
        url.append(queryItems: [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "station", value: airportIATACode),
            URLQueryItem(name: "lang", value: "ru_RU"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "date", value: date.ISO8601Format()),
            URLQueryItem(name: "system", value: "iata"),
            
        ])
        
        switch type {
        case .arrivals:
            url.append(queryItems: [URLQueryItem(name: "event", value: "arrival")])
        case .departures:
            url.append(queryItems: [URLQueryItem(name: "event", value: "departure")])
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            
            let flights = try decoder.decode(FlightsResponse.self, from: data).schedule
            guard !flights.isEmpty else { throw NetworkError.emptyData }
            
            return flights
        } catch {
            throw error
        }
    }
    
    func getCopyright() async throws -> Copyright {
        guard var url = URL(string: baseURL) else { throw NetworkError.invalidURL }
        
        url.append(path: "copyright")
        url.append(queryItems: [URLQueryItem(name: "apikey", value: apiKey)])
        
        do {
            let (data, _) = try await session.data(from: url)

            return try decoder.decode(CopyrightResponse.self, from: data).copyright
        } catch {
            throw error
        }
    }
}
