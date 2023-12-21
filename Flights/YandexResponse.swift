//
//  YandexResponse.swift
//  Flights
//
//  Created by Daniil Rassadin on 20/12/23.
//

import Foundation

struct YandexResponse: Decodable {
    let schedule: [Flight]
}

struct Flight: Decodable {
    var number: String { thread.number }
    var title: String { thread.title }
    var vehicle: String? { thread.vehicle }
    
    private let thread: Thread
    private struct Thread: Decodable {
        let number: String
        let title: String
        let vehicle: String?
    }
}


