// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Modellierung einer Adresse
struct Address: Codable {
    enum CodingKeys: String, CodingKey {
        case addressCode = "AddressCode"
        case privateCodes = "PrivateCode"
        case addressName = "AddressName"
        case nameSuffix = "NameSuffix"
        case countryName = "CountryName"
        case postalCode = "PostalCode"
        case localityName = "LocalityName"
        case localityRef = "LocalityRef"
        case streetName = "StreetName"
        case houseNumber = "HouseNumber"
        case crossingStreet = "CrossingStreet"
    }
    
    /// Identifikator der Adresse. Vgl. 7.5.1
    let addressCode: String
    /// Privater Code für diesen Haltepunkt in einem anderen Schlüsselsystem
    let privateCodes: [PrivateCode]?
    /// Adressbeschriftung für Fahrgastinformation
    let addressName: InternationalText
    /// Namenszusatz, der bei Platzmangel evtl. auch weggelassen werden kann, z. B.: „Messe/Exhibition Center“
    let nameSuffix: InternationalText?
    
    // MARK: Address Detail
    /// Angabe zum Land
    let countryName: String?
    /// Postleitzahl
    let postalCode: String?
    /// Name der Stadt oder Ortschaft, in der die Adresse liegt
    let localityName: String?
    /// Referenz auf die Stadt oder Ortschaft, zu der diese Adresse gehört. Vgl. 7.5.1.
    let localityRef: String?
    /// Name der Straße, in der die Adresse liegt
    let streetName: String?
    /// Hausnummer. Falls leer, kann a) in CrossingStreet eine Kreuzung angegeben werden oder b) die Straße ist als Ganzes gemeint
    let houseNumber: String?
    /// Name der kreuzenden Straße
    let crossingStreet: String?
}
