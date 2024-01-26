//
//  CopyrightResponse.swift
//  Flights
//
//  Created by Daniil Rassadin on 26/1/24.
//

import Foundation

struct CopyrightResponse: Decodable {
    let copyright: Copyright
}

struct Copyright: Decodable {
    let text: String
    let url: String
}
