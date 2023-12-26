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
    let arrival: Date?
    let departure: Date?
    var carrierTitle: String { thread.carrier.title }
    var carrierIATA: String { thread.carrier.codes.iata }
    let terminal: String?
    
    private let thread: Thread
    private struct Thread: Decodable {
        let number: String
        let title: String
        let vehicle: String?
        
        let carrier: Carrier
        struct Carrier: Decodable {
            let title: String
            
            let codes: Code
            struct Code: Decodable {
                let iata: String
            }
        }
    }
}


