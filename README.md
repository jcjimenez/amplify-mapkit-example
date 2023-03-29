# amplify-mapkit-example
A sample Swift library that illustrates AWS Amplify's Geo category with Apple's MapKit integration.

This example may be built using the usual:

```
swift build
```

For more details, please refer to the [GeoView.swift](Sources/amplify-mapkit-example/GeoView.swift)
file - if you're in a hurry, you can try something like:

```
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
        annotationItems: $model.locations) {
            MapMarker(coordinate: $0.coordinates.wrappedValue, tint: .orange)
        }
}.padding()
```

