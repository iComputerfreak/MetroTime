// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

@main
struct MetroTimeApp: App {
    // TODO: Move models into AppData and add protocols in AppDomain (e.g. DepartureProtocol)
    // TODO: Move existing protocols into AppDomain
    // TODO: Create service for API and for favorited stops and lines (incl. protocol)
    // TODO: Services should not use other services
    // TODO: Inject services into view hiearchy
    // TODO: If a ViewModel needs to use a service, pass it into the function that needs to use it
    // TODO: OSLog Logging
    
    /*
     - RemoteTriasAPI: TriasAPI (fetches the data from TRIAS)
        - MockTriasAPI, PreviewTriasAPI
        - Should the TriasAPI return API models or app models? => app models
     - TriasDepartureService: DepartureService (uses a TriasAPI to fetch the data and map it)
        - MockDepartureService, PreviewDepartureService
     - ViewModel (uses a DepartureService to get the data the view needs)
     
     - API Components:
        - API (incl. baseURL)
        - Endpoint (path)
        - enum HTTPMethod (GET, POST, ...)
        - APIRequest<ResponseType>
            - DeparturesAPIRequest<[Departure]>
            - StationsSearchAPIRequest<[Station]>
            - LinesAtStationAPIRequest<[Line]>
     */
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
