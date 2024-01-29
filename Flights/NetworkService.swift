//
//  NetworkService.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import Foundation

protocol NetworkService {
    func getFlight(_ type: FlightsType, date: Date, airportIATACode: String) async throws -> FlightsResponse
    func getCopyright() async throws -> Copyright
}

enum NetworkError: Error {
    case invalidURL, emptyData
}

final class YandexNetworkService: NetworkService {
    
    // MARK: - Properties
    private let baseURL = "https://api.rasp.yandex.net/v3.0"
    private let session = URLSession.shared
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    // MARK: - Yandex requests
    func getFlight(_ type: FlightsType, date: Date, airportIATACode: String) async throws -> FlightsResponse {
        guard var url = URL(string: baseURL) else { throw NetworkError.invalidURL }
        
        /* This formatter is made to fix a bug where you sometimes send a date with a time zone, and because of time zone, it becomes a different date to the server. So, the formatter removes the time and time zone from the date. */
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate]
        
        url.append(path: "schedule")
        url.append(queryItems: [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "station", value: airportIATACode),
            URLQueryItem(name: "lang", value: "ru_RU"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "date", value: isoDateFormatter.string(from: date)),
            URLQueryItem(name: "system", value: "iata"),
            URLQueryItem(name: "show_systems", value: "iata"),
            URLQueryItem(name: "limit", value: "500"),
        ])
        
        switch type {
        case .arrivals:
            url.append(queryItems: [URLQueryItem(name: "event", value: "arrival")])
        case .departures:
            url.append(queryItems: [URLQueryItem(name: "event", value: "departure")])
        }
        
        let (data, _) = try await session.data(from: url)
        
        let flightsResponse = try decoder.decode(FlightsResponse.self, from: data)
        guard !flightsResponse.schedule.isEmpty else { throw NetworkError.emptyData }
        
        return flightsResponse
    }
    
    func getCopyright() async throws -> Copyright {
        guard var url = URL(string: baseURL) else { throw NetworkError.invalidURL }
        
        url.append(path: "copyright")
        url.append(queryItems: [URLQueryItem(name: "apikey", value: apiKey)])
        
        let (data, _) = try await session.data(from: url)
        
        return try decoder.decode(CopyrightResponse.self, from: data).copyright
    }
}
