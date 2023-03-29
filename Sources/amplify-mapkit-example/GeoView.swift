//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import MapKit
import SwiftUI

/// This is a barebones sample that illustrates how Amplify's [Geo](https://docs.amplify.aws/lib/geo/getting-started/q/platform/ios/)
/// features can be used alongside Apple's MapKit.
///
/// - Tag: GeoView
struct GeoView: View {

    @ObservedObject var model = GeoViewModel()

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $model.searchTerms, onEditingChanged: model.search)
                Button("Search") { model.search(false) }
                Button("Reverse Search", action: model.reverseSearch)
            }
            if let error = model.error {
                Text(String(describing: error))
            }
            Map(coordinateRegion: $model.region,
                showsUserLocation: true,
                annotationItems: $model.locations) { place in
                return MapMarker(coordinate: place.coordinates.wrappedValue, tint: .orange)
            }
        }.padding()
    }
}
