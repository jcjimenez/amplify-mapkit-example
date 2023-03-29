//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import MapKit

/// Sample `Identifiable` wrapper around Amplify's [Geo.Place](x-source-tag://Geo.Place)
/// type.
///
/// - Tag: GeoLocation
struct GeoLocation: Identifiable {
    var id: String
    var label: String
    var coordinates: CLLocationCoordinate2D
    init(place: Geo.Place) {
        let components: [String] = [
            String(describing: place.coordinates),
            place.label ?? "",
            place.addressNumber ?? "",
            place.street ?? "",
            place.municipality ?? "",
            place.neighborhood ?? "",
            place.region ?? "",
            place.subRegion ?? "",
            place.postalCode ?? "",
            place.country ?? ""
        ]
        let delimitedComponents = String(components.joined(separator: " "))
        self.id = String(describing: place.coordinates) + delimitedComponents
        self.label = place.label ?? delimitedComponents
        self.coordinates = CLLocationCoordinate2D(latitude: place.coordinates.latitude,
                                                  longitude: place.coordinates.longitude)
    }
}
