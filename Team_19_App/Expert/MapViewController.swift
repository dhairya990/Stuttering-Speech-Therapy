//
//  MapViewController.swift
//  Team_19_App
//
//  Created by Sambhav Singh on 24/05/24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var doctor : DoctorData?
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        configureSheets()
    }
    
    private func configureSheets(){
        let vc = bottomViewViewController()
        let naVC = UINavigationController(rootViewController: vc)
        naVC.isModalInPresentation = true
        if let sheet = naVC.sheetPresentationController{
            sheet.preferredCornerRadius = 30
            sheet.detents = [.custom(resolver: { context in
                0.3 * context.maximumDetentValue
            }) , .large()]
            
            
            let itemsdoc = doctor
            sheet.largestUndimmedDetentIdentifier = .large
            vc.updateUI(with: "Dr. Gupta", distance: "2.5Km", type: "Child Speacialist", address: "Ram Nagar", status: "Closed", hours: "9:00 to 5:00", image: UIImage(named: "Image 10"))
        }
        navigationController?.present(naVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Dismiss the presented view controller if it's presented
            if let presentedVC = self.presentedViewController {
                presentedVC.dismiss(animated: true, completion: nil)
            }
        }
}

extension MapViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates:CLLocationCoordinate2D = manager.location!.coordinate
        let spanDgree = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinates, span: spanDgree)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = "YOO"
        mapView.addAnnotation(annotation)
    }
}
