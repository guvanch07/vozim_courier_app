//
//  MapViewModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 11.08.23.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject,CLLocationManagerDelegate{
    @Published var mapView = MKMapView()
    
    // Region ..
    @Published var region: MKCoordinateRegion!
    @Published var permissionDenided = false
    @Published var searchTxt = ""
    @Published var mapType : MKMapType = .standard
    @Published var places : [Place] = []
    
    func upateMapType()  {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        }
        else{
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func focusLocation() {
        guard let _ = region else {return}
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    // Search Places ..
    func searchQuery()  {
        places.removeAll()
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        // Fetch ..
        MKLocalSearch(request: request).start{(response,_) in
            guard let result = response else {return}
            self.places = result.mapItems.compactMap({ (item)-> Place? in
                return Place(placemark: item.placemark)
            })
            
        }
    }
    
    func selectPlcae(place:Place)  {
        searchTxt = ""
        guard let coordinate = place.placemark.location?.coordinate else {return}
        let pointAnnotion = MKPointAnnotation()
        pointAnnotion.coordinate = coordinate
        pointAnnotion.title = place.placemark.name ?? "No name"
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotion)
        
        //moving
        
        let corrdnateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(corrdnateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        // Checking permitions ..
        switch manager.authorizationStatus{
        case .denied:
            permissionDenided.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:()
        }
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    // Getting user Region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{return}
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        // Updating Map..
        self.mapView.setRegion(self.region, animated: true)
        // Smooth animations ..
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
     
}
