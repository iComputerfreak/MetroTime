// Copyright © 2024 Jonas Frey. All rights reserved.

import SwiftUI

@main
struct MetroTimeApp: App {
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
