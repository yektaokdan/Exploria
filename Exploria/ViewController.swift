//
//  ViewController.swift
//  Exploria
//
//  Created by yekta on 7.02.2024.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var lastAddedAnnotation:MKPointAnnotation?
    var titleText:String?
    var subtitleText:String?
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        //kullanicinin konumunun ne derecede dogru bulunacagi hakkinda
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //konum bilgilerini ne siklikla kontrol edecegimiz, biz sadece uygulama kullanilirken olarak sectik
        locationManager.requestWhenInUseAuthorization()
        //kullanicinin yerini alma
        locationManager.startUpdatingLocation()
        //mavi yuvarlak ile kullanicinin (cihazin) lokasyonunu gostermek
        mapView.showsUserLocation = true
        
        
        //Gesture Recognizer
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 1.5
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @objc func chooseLocation(gestureRecognizer:UIGestureRecognizer){
        if gestureRecognizer.state == .began{
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            //pin olusturma ve ihtiyac duydugu degerleri belirtme
            openModalForCoordinates(touchedCoordinates)
        }
    }
    
    func openModalForCoordinates(_ coordinates: CLLocationCoordinate2D){
        let alertController  = UIAlertController(title: "Add a new location", message: "Entry location details", preferredStyle: .alert)
        alertController.addTextField{textField in
            textField.placeholder = "Name"
        }
        alertController.addTextField{textField in
            textField.placeholder = "Comment"
        }
        // Kullanıcı "Kaydet" butonuna bastığında çağrılacak aksiyon
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak alertController] _ in
            guard let textFields = alertController?.textFields else { return }
            self.titleText = textFields[0].text ?? ""
            self.subtitleText = textFields[1].text ?? ""
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = self.titleText
            annotation.subtitle = self.subtitleText
            self.mapView.addAnnotation(annotation)
            self.lastAddedAnnotation = annotation
            
            //CoreData baglantisi
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newPin = NSEntityDescription.insertNewObject(forEntityName: "Locations", into: context)
            newPin.setValue(UUID(), forKey: "id")
            newPin.setValue(self.titleText, forKey: "name")
            newPin.setValue(self.subtitleText, forKey: "comment")
            newPin.setValue(coordinates.latitude, forKey: "latitude")
            newPin.setValue(coordinates.longitude, forKey: "longitude")
            do{
                try context.save()
                print("success")
            } catch{
                print("error")
            }
            NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
                    //islem bittikten sonra bir onceki ekrana gecis yapmayi saglar
                    self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(saveAction)
        
        // İptal butonu ekleniyor
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            if let annotation = self?.lastAddedAnnotation {
                self?.mapView.removeAnnotation(annotation)
                self?.lastAddedAnnotation = nil // Referansı sıfırla
            }
        }
        alertController.addAction(cancelAction)
        
        // Hazırlanan alert controller'ı göster
        present(alertController, animated: true, completion: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //enlem - boylam degerlerini bulmak icin
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        //zoom seviyesi icin
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        //gozuken kisim, center: nereyi merkez alayim, span: ne kadar zoomlayayim
        let region = MKCoordinateRegion(center: location, span: span)
        //en son view uzerindeki mapkite eriserek bu regionu atamamiz gerekiyor
        mapView.setRegion(region, animated: true)
    }
    
    
}

