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
        Airport(name: "Domodedovo", iataCode: "DME", city: "Moscow"),
        Airport(name: "Pulkovo", iataCode: "LED", city: "Saint-Petersburg"),
        Airport(name: "Sheremetyevo", iataCode: "SVO", city: "Moscow"),
        Airport(name: "Koltsovo", iataCode: "SVX", city: "Yekaterinburg"),
        Airport(name: "Tolmachevo", iataCode: "OVB", city: "Novosibirsk"),
        Airport(name: "Vnukovo", iataCode: "VKO", city: "Moscow"),
        Airport(name: "Sochi", iataCode: "AER", city: "Sochi"),
        Airport(name: "Kazan", iataCode: "KZN", city: "Kazan"),
        Airport(name: "Yemelyanovo", iataCode: "KJA", city: "Krasnoyarsk"),
        Airport(name: "Ufa", iataCode: "UFA", city: "Ufa"),
        Airport(name: "Kurumoch", iataCode: "KUF", city: "Samara"),
        Airport(name: "Platov", iataCode: "ROV", city: "Rostov-on-Don"),
        Airport(name: "Khabarovsk-Novy", iataCode: "KHV", city: "Khabarovsk"),
        Airport(name: "Zhukovsky", iataCode: "ZIA", city: "Moscow"),
        Airport(name: "Krasnodar Pashkovsky", iataCode: "KRR", city: "Krasnodar"),
        Airport(name: "Vladivostok", iataCode: "VVO", city: "Vladivostok"),
        Airport(name: "Irkutsk", iataCode: "IKT", city: "Irkutsk"),
        Airport(name: "Khrabrovo", iataCode: "KGD", city: "Kaliningrad"),
        Airport(name: "Yakutsk", iataCode: "YKS", city: "Yakutsk"),
        Airport(name: "Chita-Kadala", iataCode: "HTA", city: "Chita"),
        Airport(name: "Omsk Central", iataCode: "OMS", city: "Omsk"),
        Airport(name: "Roshchino", iataCode: "TJM", city: "Tyumen"),
        Airport(name: "Talagi", iataCode: "ARH", city: "Arkhangelsk"),
        Airport(name: "Narimanovo", iataCode: "ASF", city: "Astrakhan"),
        Airport(name: "Barnaul", iataCode: "BAX", city: "Barnaul"),
        Airport(name: "Tunoshna", iataCode: "IAR", city: "Yaroslavl"),
        Airport(name: "Balandino", iataCode: "CEK", city: "Chelyabinsk"),
        Airport(name: "Khanty-Mansiysk", iataCode: "HMA", city: "Khanty-Mansiysk"),
        Airport(name: "Baikal", iataCode: "UUD", city: "Ulan-Ude"),
        Airport(name: "Gagarinsky", iataCode: "GSV", city: "Saratov"),
        Airport(name: "Besovets", iataCode: "PES", city: "Petrozavodsk"),
        Airport(name: "Perm", iataCode: "PEE", city: "Perm")
    ]
}
