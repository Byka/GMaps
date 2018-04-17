//
//  PositionChangeViewController.swift
//  G Maps
//
//  Created by Srinivas Byka on 4/16/18.
//  Copyright © 2018 BYKA. All rights reserved.
//

import UIKit

import CoreLocation
import GoogleMaps


class PositionChangeViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate  {

    let locationManager = CLLocationManager()
    
    var mapView:GMSMapView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        
        //        if (CLLocationManager.locationServicesEnabled()) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 14.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        mapView?.isMyLocationEnabled = true
        mapView?.settings.compassButton = true
        mapView?.settings.myLocationButton = true
        
        mapView?.animate(toLocation: CLLocationCoordinate2D(latitude: -33.868, longitude: 151.208))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationObj = locations.last!
        let coord = locationObj.coordinate
        /*longitude.text = coord.longitude
         latitude.text = coord.latitude
         longitude.text = "\(coord.longitude)"
         latitude.text = "\(coord.latitude)"*/
        
        loadView(with: coord.latitude, longitude: coord.longitude)
        
        //locationManager.stopUpdatingLocation()
    }

    
    let infoMarker = GMSMarker()

    // Attach an info window to the POI using the GMSMarker.
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String,
                 name: String, location: CLLocationCoordinate2D) {
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
    
    /*
     //Map gesture
     func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
     print("willMove")
     }
     
     func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
     
     }
     
     func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
    
    let coor = marker.position
     
     
     print(coor.latitude, coor.longitude)
     
    }
    */
    
    
    
    func loadView(with latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        
        
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        //marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        let data = UIImagePNGRepresentation(UIImage(named:"cmap_pin")!)
        
        
        marker.title = "PCC"
        marker.icon = UIImage(data: data!, scale:2.0)
        marker.map = mapView
        
        
        marker.isDraggable = true

        
        geocoder.reverseGeocodeCoordinate(camera.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                //let marker = GMSMarker()
                //marker.position = cameraPosition.target
                marker.title = result.lines?[0]
                marker.snippet = result.lines?[1]
                marker.map = mapView
                
                print(result)
            }
        }
        //let position = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.127)
       
        
        //waypointService()
        
        /*
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
         
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                marker.position = cameraPosition.target
                marker.title = result.lines?[0]
                marker.snippet = result.lines?[1]
                marker.map = mapView
         
                print(result)
            }
        }
        */
        
    }
    
    //MARK: Mapview delegate methods
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
        mapView.clear()
    }
    
    let geocoder = GMSGeocoder()
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                marker.position = cameraPosition.target
                marker.title = result.lines?[0]
                marker.snippet = result.lines?[1]
                marker.map = mapView
                
                print(result)
            }
        }
    }
    

}
