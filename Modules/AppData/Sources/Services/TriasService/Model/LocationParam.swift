// Copyright © 2024 Jonas Frey. All rights reserved.

import Foundation

enum LocationParamType: String, Codable {
    case stop
    case address
    case poi
    case coord
    case locality
}

enum LocationParamUsage: String, Codable {
    case origin
    case destination
    case via
}

/// Fasst Anfrageparameter zusammen, die im Ortsinformationsdienst verwendet werden
struct LocationParam: Codable {
    enum CodingKeys: String, CodingKey {
        case types = "Type"
        case usage = "Usage"
        case ptModes = "PtModes"
        case operatorFilter = "OperatorFilter"
        case localityRefs = "LocalityRef"
        case pointOfInterestFilter = "PointOfInterestFilter"
        case language = "Language"
        case numberOfResults = "NumberOfResults"
        case continueAt = "ContinueAt"
        case includePTModes = "IncludePtModes"
    }
    
    // TODO: Add newlines between properties
    
    // MARK: Location Data Filter
    /// Erlaubte Ortsobjektstypen.
    ///
    /// Falls welche angegeben werden, dürfen nur Ortsobjekte zurückgegeben werden,
    /// die von einem der angegebenen Typen sind. Falls keine angegeben werden, sind alle Objekttypen erlaubt.
    let types: [LocationParamType]?
    /// Verwendung des Ortsobjektes.
    ///
    /// Falls angegeben, teilt dies dem Dienst mit, als was das gesuchte Ortsobjekt verwendet werden soll.
    /// Der Ortsinformationsdienst darf dann nur Objekte zurückgeben, die für die angegebene Verwendung freigegeben sind
    let usage: LocationParamUsage?
    /// Erlaubte Verkehrsmittel.
    ///
    /// Falls angegeben, dürfen nur solche Ortsobjekte zurückgegeben werden,
    /// an denen Verkehre fahren, die dem Filter entsprechen. Dies schließt automatisch alle Nicht-Haltestellen aus. Vgl. 7.3.5
    let ptModes: PTModeFilter?
    /// Die Suche wird auf solche Ortsobjekte eingeschränkt, die von bestimmten Unternehmen betrieben/nicht betrieben werden (vgl. 7.4.4).
    let operatorFilter: OperatorFilter?
    /// Erlaubte Lokalitäten.
    ///
    /// Falls angegeben, dürfen nur solche Ortsobjekte zurückgegeben werden,
    /// die mindestens einer der gegebenen Lokalitäten zugeordnet sind. Vgl. 7.5.1
    let localityRefs: [String]?
    /// Ermöglicht, eine POI-Suche auf bestimmte POI-Kategorien einzuschränken (vgl. 7.5.6).
    let pointOfInterestFilter: PointOfInterestFilter?
    
    // MARK: Location Policy
    
    /// Bevorzugte Sprache für die zurückgegebenen Texte. Dies muss nicht unbedingt Einfluss auf die Namen der Ortsobjekte haben
    let language: String?
    /// Anzahl der maximal zurückzugebenen Ortsobjekte.
    ///
    /// Der Dienst kann durchaus weniger Objekte zurückgeben, falls sinnvoll oder falls sonst der Dienst überfordert wäre.
    /// Falls mehr Objekte die Anfrage erfüllen (z. B. wenn alle Objekte abgerufen werden sollen), kann mit diesem Parameter die Menge der Objekte,
    /// die in einem Abruf maximal übertragen werden, begrenzt werden.
    /// Ein Ortsinformationsdienst muss in der Lage sein, mindestens 500 Ortsobjekte in einer Antwort zurückzugeben
    let numberOfResults: Int?
    /// Falls angegeben, weist dieser Parameter den Dienst an, wieviele Objekte in der Rückgabe übersprungen werden sollen.
    ///
    /// Falls bei einem Abruf von Ortsobjekten nicht alle passenden Objekte geliefert werden konnten, teilt der Dienst dies in seiner Antwort im Feld
    /// ContinueAt mit (vgl. 8.4.1).
    /// Um die weiteren Objekte abzurufen, wird die Anfrage an den Ortsinformationsdienst exakt wiederholt,
    /// wobei dieser Parameter angegeben wird, indem der Wert aus der letzten Diensteantwort eingefüllt wird.
    let continueAt: Int?
    /// Teilt dem Dienst mit, an Haltestellen die verfügbaren Verkehrsmittel mit zurück zu geben. Default ist false.
    let includePTModes: Bool?
    
    init(
        types: [LocationParamType]? = nil,
        usage: LocationParamUsage? = nil,
        ptModes: PTModeFilter? = nil,
        operatorFilter: OperatorFilter? = nil,
        localityRefs: [String]? = nil,
        pointOfInterestFilter: PointOfInterestFilter? = nil,
        language: String? = nil,
        numberOfResults: Int? = nil,
        continueAt: Int? = nil,
        includePTModes: Bool? = nil
    ) {
        self.types = types
        self.usage = usage
        self.ptModes = ptModes
        self.operatorFilter = operatorFilter
        self.localityRefs = localityRefs
        self.pointOfInterestFilter = pointOfInterestFilter
        self.language = language
        self.numberOfResults = numberOfResults
        self.continueAt = continueAt
        self.includePTModes = includePTModes
    }
}
