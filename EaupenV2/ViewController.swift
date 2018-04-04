//
//  ViewController.swift
//  EaupenV2
//
//  Created by Hugo Gomez on 15/02/2018.
//  Copyright © 2018 Hugo Gomez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import RxSwift

class ViewController: UIViewController, LocatorDelegate {
    
//    var amenities: [Amenity]? {
//        didSet { DispatchQueue.main.async(execute : { self.initData() }) }
//    }
    
    var amenities: [Amenity]?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var mapView: MKMapView!
    
    func locator(_ locator: Locator, didUpdateLocation location: CLLocation) {
        print("Location succeded")
        let alertController = UIAlertController(title: "Location succeded", message: "", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true)
        self.setMapView(center: location.coordinate)
        self.setAmenities(coordinates: location.coordinate)
        return
    }
    
    func initData() {
        guard let amenities = self.amenities, amenities.count > 0 else {
            let alertController = UIAlertController(title: "Aucun point d'eau trouvé", message: "", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
            return
        }
        
        for amenity in amenities {
            if let annotation = Annotation.init(amenity: amenity) {
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    func setMapView(center: CLLocationCoordinate2D) {
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 2000.0)
        mapView.setCamera(camera, animated: false)
    }
    
    
    @IBAction func locate(_ sender: Any) {
        print("Start Location..")
        self.clearAnnotations()
        Locator.shared.start(delegate: self)
    }
    
    func clearAnnotations() {
        mapView.removeAnnotations(mapView.annotations)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setAmenities(coordinates: CLLocationCoordinate2D(latitude: 48.831034, longitude: 2.355265))
        self.setMapView(center: CLLocationCoordinate2D(latitude: 48.831034, longitude: 2.355265))
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveUserLocation(coordinate: CLLocationCoordinate2D) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "userLocationExists")
        defaults.set(coordinate.latitude, forKey: "latitude")
        defaults.set(coordinate.longitude, forKey: "longitude")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showAmenity", let amenity = sender as? Amenity else { return }
        
        let controller = segue.destination as! AmenityViewController
        controller.amenity = amenity
    }
    
}
    
extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotations: MKAnnotation) -> MKAnnotationView? {
        
        switch annotations {
            
        case is MKUserLocation:
            return nil
        
        case is Annotation:
            let view = MKPinAnnotationView(annotation: annotations, reuseIdentifier: nil)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return view
            
        default:
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard
            control == view.rightCalloutAccessoryView,
            let annotation = view.annotation as? Annotation
        else { return }
        
        let amenity = annotation.amenity
        self.performSegue(withIdentifier: "showAmenity", sender: amenity)
    }
}


