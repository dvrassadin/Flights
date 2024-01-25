//
//  Airport.swift
//  Flights
//
//  Created by Daniil Rassadin on 28/12/23.
//

import Foundation

struct Airport {
    let name: String
    let iataCode: String
    let city: String
}

extension Airport {
    static let airports = [
        Airport(name: String(localized: "Domodedovo"), iataCode: "DME", city: String(localized: "Moscow")),
        Airport(name: String(localized: "Pulkovo"), iataCode: "LED", city: String(localized: "Saint-Petersburg")),
        Airport(name: String(localized: "Sheremetyevo"), iataCode: "SVO", city: String(localized: "Moscow")),
        Airport(name: String(localized: "Koltsovo"), iataCode: "SVX", city: String(localized: "Yekaterinburg")),
        Airport(name: String(localized: "Tolmachevo"), iataCode: "OVB", city: String(localized: "Novosibirsk")),
        Airport(name: String(localized: "Vnukovo"), iataCode: "VKO", city: String(localized: "Moscow")),
        Airport(name: String(localized: "Sochi"), iataCode: "AER", city: String(localized: "Sochi")),
        Airport(name: String(localized: "Kazan"), iataCode: "KZN", city: String(localized: "Kazan")),
        Airport(name: String(localized: "Yemelyanovo"), iataCode: "KJA", city: String(localized: "Krasnoyarsk")),
        Airport(name: String(localized: "Ufa"), iataCode: "UFA", city: String(localized: "Ufa")),
        Airport(name: String(localized: "Kurumoch"), iataCode: "KUF", city: String(localized: "Samara")),
        Airport(name: String(localized: "Platov"), iataCode: "ROV", city: String(localized: "Rostov-on-Don")),
        Airport(name: String(localized: "Khabarovsk-Novy"), iataCode: "KHV", city: String(localized: "Khabarovsk")),
        Airport(name: String(localized: "Zhukovsky"), iataCode: "ZIA", city: String(localized: "Moscow")),
        Airport(name: String(localized: "Pashkovsky"), iataCode: "KRR", city: String(localized: "Krasnodar")),
        Airport(name: String(localized: "Vladivostok"), iataCode: "VVO", city: String(localized: "Vladivostok")),
        Airport(name: String(localized: "Irkutsk"), iataCode: "IKT", city: String(localized: "Irkutsk")),
        Airport(name: String(localized: "Khrabrovo"), iataCode: "KGD", city: String(localized: "Kaliningrad")),
        Airport(name: String(localized: "Yakutsk"), iataCode: "YKS", city: String(localized: "Yakutsk")),
        Airport(name: String(localized: "Kadala"), iataCode: "HTA", city: String(localized: "Chita")),
        Airport(name: String(localized: "Omsk Central"), iataCode: "OMS", city: String(localized: "Omsk")),
        Airport(name: String(localized: "Roshchino"), iataCode: "TJM", city: String(localized: "Tyumen")),
        Airport(name: String(localized: "Talagi"), iataCode: "ARH", city: String(localized: "Arkhangelsk")),
        Airport(name: String(localized: "Astrakhan"), iataCode: "ASF", city: String(localized: "Astrakhan")),
        Airport(name: String(localized: "Barnaul"), iataCode: "BAX", city: String(localized: "Barnaul")),
        Airport(name: String(localized: "Tunoshna"), iataCode: "IAR", city: String(localized: "Yaroslavl")),
        Airport(name: String(localized: "Balandino"), iataCode: "CEK", city: String(localized: "Chelyabinsk")),
        Airport(name: String(localized: "Khanty-Mansiysk"), iataCode: "HMA", city: String(localized: "Khanty-Mansiysk")),
        Airport(name: String(localized: "Baikal"), iataCode: "UUD", city: String(localized: "Ulan-Ude")),
        Airport(name: String(localized: "Gagarinsky"), iataCode: "GSV", city: String(localized: "Saratov")),
        Airport(name: String(localized: "Besovets"), iataCode: "PES", city: String(localized: "Petrozavodsk")),
        Airport(name: String(localized: "Perm"), iataCode: "PEE", city: String(localized: "Perm"))
    ]
}
