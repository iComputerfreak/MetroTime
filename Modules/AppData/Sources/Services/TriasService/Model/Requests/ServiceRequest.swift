// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

/// Grundstruktur für jede TRIAS-Anfrage (ohne Abonnement).
struct ServiceRequest<Request: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
        case requestTimestamp = "siri:RequestTimestamp"
        case address = "Address"
        case requestorRef = "siri:RequestorRef"
        case messageIdentifier = "MessageIdentifier"
        case dataVersion = "DataVersion"
        case language = "Language"
        case signature = "Signature"
        case certificateID = "CertificateId"
        case payload = "RequestPayload"
    }
    
    // MARK: - Inherited from AbstractTriasResponse
    
    // MARK: siri:ContextualisedRequest
    /// Zeistempel der Anfrage
    let requestTimestamp: Date
    
    // MARK: siri:ProducerResponseEndpoint
    /// Adresse, an die die Antwort gesendet werden soll. Kann auch mittels RequestorRef aus der Konfiguration ermittelt werden
    let address: String?
    /// ID des Anfragers
    let requestorRef: String
    /// Beliebige, eindeutige ID, mit der diese Nachricht referenziert werden kann
    let messageIdentifier: String?
    
    // MARK: Service Request Context
    /// Datenversion, die vom Server bei der Bearbeitung benutzt werden soll
    let dataVersion: String?
    /// Bevorzugte Sprache, in der Texte in der Antwort zurückgegeben werden sollen
    /// Example: `de`
    let language: String?
    
    // MARK: MessageIntegrityProperties
    /// Signatur der Nachricht
    let signature: String?
    /// Zertifikat-ID für die Überprüfung der Nachricht
    let certificateID: String?
    
    // MARK: -
    /// Dienstspezifischer Anfrageinhalt (vgl. 7.1.3).
    let payload: ServicePayload<Request>
    
    init(
        requestTimestamp: Date,
        address: String? = nil,
        requestorRef: String,
        messageIdentifier: String? = nil,
        dataVersion: String? = nil,
        language: String? = nil,
        signature: String? = nil,
        certificateID: String? = nil,
        payload: ServicePayload<Request>
    ) {
        self.requestTimestamp = requestTimestamp
        self.address = address
        self.requestorRef = requestorRef
        self.messageIdentifier = messageIdentifier
        self.dataVersion = dataVersion
        self.language = language
        self.signature = signature
        self.certificateID = certificateID
        self.payload = payload
    }
}
