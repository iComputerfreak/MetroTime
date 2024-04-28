// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Grundstruktur für jede TRIAS-spezifische Antwort
/// - NOTE: See 7.1.4 ServiceDeliveryStructure
struct ServiceDelivery<Response: Decodable>: Decodable {
    enum CodingKeys: String, CodingKey {
        case responseTimestamp = "ResponseTimestamp"
        case producerRef = "ProducerRef"
        case address = "Address"
        case responseMessageIdentifier = "ResponseMessageIdentifier"
        case requestMessageRef = "RequestMessageRef"
        case status = "Status"
        case errorCondition = "ErrorCondition"
        case moreData = "MoreData"
        case dataVersion = "DataVersion"
        case language = "Language"
        case calcTime = "CalcTime"
        case signature = "Signature"
        case certificateID = "CertificateId"
        case payload = "DeliveryPayload"
    }
    
    // MARK: - Inherited from AbstractTriasResponse
    
    // MARK: siri:ProducerResponse
    /// Zeistempel der Antwort
    let responseTimestamp: Date
    
    // MARK: siri:ProducerResponseEndpoint
    /// ID des antwortenden Teilnehmers
    let producerRef: String
    /// Adresse, an die eine etwaige Empfangsbestätigung für den Erhalt der Nachricht gesendet werden soll.
    /// Kann auch mittels RequestorRef aus der Konfiguration ermittelt werden.
    let address: String?
    /// Beliebige, eindeutige ID, mit der diese Nachricht referenziert werden kann
    let responseMessageIdentifier: String?
    /// Referenz auf die Anfragenachricht, die diese Antwortnachricht ausgelöst hat
    let requestMessageRef: String?
    
    // MARK: ResponseStatus
    /// Indikator, ob die gesamte Anfrage komplett erfolgreich bearbeitet werden konnte. Default ist `true`.
    let status: Bool?
    /// SIRI-Fehlerzustände, die die Bearbeitung der Anfrage als Ganzes betreffen. Siehe auch (CEN, TS 15531, Part 2), Kap. 5.7.
    let errorCondition: String?
    /// Indikator, ob noch weitere Aktualisierungen vorliegen, die abgerufen werden könnten. Default ist `false`.
    let moreData: Bool?
    
    // MARK: ServiceResponseContext
    /// Datenversion, die vom Server bei der Bearbeitung benutzt wurde
    let dataVersion: String?
    /// Sprache, in der Texte in der Antwort zurückgegeben wurden
    /// Example: `de`
    let language: String?
    /// Rechenzeit für die Bearbeitung der Anfrage
    let calcTime: Int?
    
    // MARK: MessageIntegrityProperties
    /// Signatur der Nachricht
    let signature: String?
    /// Zertifikat-ID für die Überprüfung der Nachricht
    let certificateID: String?
    
    // MARK: -
    /// Dienstspezifischer Antwortinhalt (vgl. 7.1.5)
    let payload: DeliveryPayload<Response>
}
