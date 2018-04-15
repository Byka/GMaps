//
//  ViewController.swift
//  G Maps
//
//  Created by Srinivasa Reddy on 15/04/18.
//  Copyright © 2018 BYKA. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps


class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        
//        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()

    }

    func loadView(with latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 16.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = self
        view = mapView
        
        // Creates a marker in the center of the map.
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        marker.isDraggable = true
        
        waypointService()
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        path.add(CLLocationCoordinate2D(latitude: latitude+0.1, longitude: longitude+0.1))
        let polyline = GMSPolyline(path: path)
        polyline.map = mapView

    }
    
    func waypointService() {
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=Gachibowly Hyderabad, Telagana,MA&destination=Ammerpeta Hyderabad, Telgana,MA&waypoints=Madhapur, Hyderabad&key=AIzaSyBIIXX9R1bP_NlYUKRmpX9JUw9HRktR7Cg"
        if let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let _ = error {
                    
                }else {
                    let json = try! JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    print(json)
                }
            }).resume()
        }
        
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
        
        locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        print("willMove")
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        let coor = marker.position
        print(coor.latitude, coor.longitude)
    }
}

