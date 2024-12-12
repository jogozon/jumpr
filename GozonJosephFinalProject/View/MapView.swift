//
//  MapView.swift
//  GozonJosephFInalProject
//
//  Created by Joseph Gozon on 12/10/24.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPostiion: MapCameraPosition = .region(.userRegion)
    @StateObject var locationDataManager = LocationDataManager()
    @State private var searchText = ""
    @State private var mapRes = [MKMapItem]()
    @State private var results = [CourtModel]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails: Bool = false
    
    
    var body: some View {
        Map(position: $cameraPostiion, selection: $mapSelection) {
            UserAnnotation()
            
            ForEach(mapRes, id: \.self) { item in
                let placemark = item.placemark
                Marker("\(placemark.name ?? "Name not available")", coordinate: placemark.coordinate)
            }
        }
        .overlay(alignment: .top) {
            TextField("Search", text: $searchText)
        }
        .mapControls({
            MapUserLocationButton()
            MapCompass()
        })
        .onSubmit(of: .text) {
            Task {
                await searchPlaces()
            }
        }
        .onChange(of: mapSelection, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            CourtDetailsView(mapSelection: $mapSelection, show: $showDetails)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        })
    }
}


extension MapView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(center: locationDataManager.locationManager.location!.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        MKLocalSearch(request: request).start { (res, error) in
            guard let res else {
                print(error ?? "There was a search error")
                return
            }
            
            self.mapRes = res.mapItems
            
        }
    }
}



#Preview {
    MapView()
}
