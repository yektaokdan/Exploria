//
//  ShowDetailsVC.swift
//  Exploria
//
//  Created by yekta on 7.02.2024.
//

import UIKit
import MapKit
import CoreData
class ShowDetailsVC: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate {
    var chosenLocationName = ""
    var chosenLocationUUID:UUID?
    var selectedLatitude:Double?
    var selectedLongitude:Double?
    @IBOutlet weak var mapViewSelected: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewSelected.delegate = self
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            mapViewSelected.showsUserLocation = true
            fetchLocation()
        
    }
    func fetchLocation() {
        guard let uuid = chosenLocationUUID else { return }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Locations> = Locations.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", uuid as CVarArg)

        do {
            let locations = try context.fetch(fetchRequest)
            if let location = locations.first {
                let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                createAnnotation(coordinate: coordinate, title: location.name ?? "", subtitle: location.comment ?? "")
                selectedLatitude = location.latitude
                selectedLongitude = location.longitude
            }
        } catch let error as NSError {
            print("Fetching Error: \(error), \(error.userInfo)")
        }
    }
    func createAnnotation(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapViewSelected.addAnnotation(annotation)
        
        // Haritayı bu koordinata odaklayın
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 2250, longitudinalMeters: 2250)
        mapViewSelected.setRegion(region, animated: true)
    }
    
    
    //NAVIGATE
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "customAnnotation") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let coordinate = view.annotation?.coordinate {
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
            mapItem.name = view.annotation?.title ?? "Destination"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
    }

}
