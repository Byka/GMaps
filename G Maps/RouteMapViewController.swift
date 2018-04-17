//
//  RouteMapViewController.swift
//  G Maps
//
//  Created by Srinivas Byka on 4/17/18.
//  Copyright © 2018 BYKA. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps


class RouteMapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
        
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
            
    }

        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let locationObj = locations.last!
            let coord = locationObj.coordinate
            
            loadView(with: coord.latitude, longitude: coord.longitude)
           
    }
    
    func loadView(with latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        
        
        let position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let marker = GMSMarker(position: position)
        let data = UIImagePNGRepresentation(UIImage(named:"cmap_pin")!)
        //marker.title = "PCC"
        marker.icon = UIImage(data: data!, scale:2.0)
        marker.map = mapView
        
        
        
//        let address = getAddressForLatLng(latitude: latitude, longitude: longitude)
//        print(address)
        
        
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
    }
    
    let geocoder = GMSGeocoder()

    /*
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        
        geocoder.reverseGeocodeCoordinate(cameraPosition.target) { (response, error) in
            guard error == nil else {
                return
            }
            
            if let result = response?.firstResult() {
                let marker = GMSMarker()
                //marker.position = cameraPosition.target
                marker.title = result.lines?[0]
                marker.snippet = result.lines?[1]
                marker.map = mapView
                
                print(result)
            }
        }
    }
    */
    
    /*
    func getAddressForLatLng(latitude: Double, longitude: Double) -> String {
        
        let url = NSURL(string: "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=AIzaSyDihjMSGx6ZOAg1pior9chiU_cSYpaaAlk")
        let data = NSData(contentsOf: url! as URL)
        if data != nil {
            let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            if let result = json["results"] as? NSArray   {
                if result.count > 0 {
                    if let addresss:NSDictionary = result[0] as! NSDictionary {
                        if let address = addresss["address_components"] as? NSArray {
                            var newaddress = ""
                            var number = ""
                            var street = ""
                            var city = ""
                            var state = ""
                            var zip = ""
                            
                            if(address.count > 1) {
                                number =  (address.object(at: 0) as! NSDictionary)["short_name"] as! String
                            }
                            if(address.count > 2) {
                                street = (address.object(at: 1) as! NSDictionary)["short_name"] as! String
                            }
                            if(address.count > 3) {
                                city = (address.object(at: 2) as! NSDictionary)["short_name"] as! String
                            }
                            if(address.count > 4) {
                                state = (address.object(at: 4) as! NSDictionary)["short_name"] as! String
                            }
                            if(address.count > 6) {
                                zip =  (address.object(at: 6) as! NSDictionary)["short_name"] as! String
                            }
                            newaddress = "\(number) \(street), \(city), \(state) \(zip)"
                            return newaddress
                        }
                        else {
                            return ""
                        }
                    }
                } else {
                    return ""
                }
            }
            else {
                return ""
            }
            
        }   else {
            return ""
        }
        
    }
    */
        /*
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
        */
        
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
        
        
        
    /*
        //MARK: Mapview delegate methods
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        }
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            
           // mapView.clear()
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
        */
        
}

