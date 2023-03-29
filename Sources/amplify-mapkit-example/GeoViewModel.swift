//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Foundation
import MapKit

/// - Tag: GeoViewModel
class GeoViewModel: ObservableObject {
    
    /// Dependency to Amplify's [GeoCategoryBehavior](x-source-tag://GeoCategoryBehavior)
    /// implementation.
    ///
    /// - Tag: GeoViewModel.geo
    var geo: GeoCategoryBehavior = Amplify.Geo
    
    /// Defaults to downtown Austin, TX
    ///
    /// - Tag: GeoViewModel.region
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 30.2672, longitude: -97.7431),
        span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125)
    )

    /// Search terms used in a text field.
    ///
    /// - Tag: GeoViewModel.searchTerms
    @Published var searchTerms: String = ""

    /// List of locations resulting from a search.
    ///
    /// - Tag: GeoViewModel.locations
    @Published var locations: [GeoLocation] = []

    /// Last error encountered when attempting to search.
    ///
    /// - Tag: GeoViewModel.error
    @Published var error: Error?
    
    /// See [Amplify.Geo.search](x-source-tag://GeoCategory.search)
    ///
    /// - Tag: GeoViewModel.search
    func search(_ stillEditing: Bool) {
        if stillEditing {
            return
        }
        let searchArea = Geo.SearchArea.near(region.center)
        let searchOptions = Geo.SearchForTextOptions(area: searchArea)
        Task {
            do {
                // Call Amplify.Geo.search(for:options:)
                let locations = try await geo.search(for: searchTerms, options: searchOptions)
                                             .map { GeoLocation(place: $0) }
                await update(locations: locations)
            } catch {
                await update(error: error)
            }
        }
    }

    /// See [Amplify.Geo.search](x-source-tag://GeoCategory.search)
    ///
    /// - Tag: GeoViewModel.reverseSearch
    func reverseSearch() {
        Task {
            do {
                let center = region.center
                let coordinates = Geo.Coordinates(latitude: center.latitude,
                                                  longitude: center.longitude)
                // Call Amplify.Geo.search(for:options:)
                let locations = try await geo.search(for: coordinates, options: nil)
                                             .map { GeoLocation(place: $0) }
                await update(locations: locations)
            } catch {
                await update(error: error)
            }
        }
    }

    private func update(locations: [GeoLocation]) async {
        await MainActor.run {
            self.locations = locations
        }
    }

    private func update(error: Error) async {
        await MainActor.run {
            self.error = error
        }
    }

}
