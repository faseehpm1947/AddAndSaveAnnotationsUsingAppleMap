//
//  LocationDetailsVC.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import UIKit
import MapKit

class LocationDetailsVC: UIViewController {

    @IBOutlet weak var btnCurrentLocation: UIButton!
    @IBOutlet weak var viewPinPointsDetails: UIView!
    @IBOutlet weak var viewNoPinPointsAvailable: UIView!
    @IBOutlet weak var tableViewPinPoints: SelfSizedTableView!
    @IBOutlet weak var segmentControlerMapViewAndPinPoints: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var viewMapDetails: UIView!
    
    var locationManager: CLLocationManager!
    let viewModel = PinPointViewModel()

    override func viewDidLoad() {
       super.viewDidLoad()
        updateView()
        setupLocationManager()
        setupViewModel()
        setupUI()
        setupTableView()
        updateMapWithPinPoints()
    }
        
    func setupViewModel() {
        viewModel.onPinPointsUpdated = { [weak self] in
            self?.tableViewPinPoints.reloadData()
            self?.updateMapWithPinPoints()
        }
    }
        
    func setupUI() {
        btnCurrentLocation.layer.cornerRadius = 5
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
        mapView.delegate = self
    }
    
    func setupTableView() {
        tableViewPinPoints.register(UINib(nibName: "PinPointTVC", bundle: nil), forCellReuseIdentifier: "PinPointTVC")
        tableViewPinPoints.delegate = self
        tableViewPinPoints.dataSource = self
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
        
    func updateView() {
        let showMap = segmentControlerMapViewAndPinPoints.selectedSegmentIndex == 0
        viewMapDetails.isHidden = !showMap
        viewPinPointsDetails.isHidden = showMap
    }
    
    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let locationInView = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            showAddPinPointAlert(at: coordinate)
        }
    }
        
    func showAddPinPointAlert(at coordinate: CLLocationCoordinate2D) {
        let alert = UIAlertController.createPinPointAlert { [weak self] title, description in
            let pinPoint = PinPoint(
                title: title,
                description: description,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
            self?.viewModel.addPinPoint(pinPoint)
        }
        present(alert, animated: true)
    }
        
    func updateMapWithPinPoints() {
        mapView.removeAnnotations(mapView.annotations)
        for pinPoint in viewModel.pinPoints {
            let annotation = MKPointAnnotation()
            annotation.title = pinPoint.title
            annotation.subtitle = pinPoint.description
            annotation.coordinate = CLLocationCoordinate2D(latitude: pinPoint.latitude, longitude: pinPoint.longitude)
            mapView.addAnnotation(annotation)
        }
    }
        
    @IBAction func segmentControlMapViewAndPinPointsChanged(_ sender: UISegmentedControl) {
        updateView()
    }
    
    @IBAction func currentLocationTapped(_ sender: Any) {
        guard let currentLocation = locationManager.location else { return }
        centerMapOnLocation(currentLocation)
    }
    
    
}

extension LocationDetailsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            centerMapOnLocation(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension LocationDetailsVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let annotationTitle = annotation.title, annotationTitle != "Your Location" else { return }
        
        let titleText = annotation.title ?? "N/A"
        let subtitleText = annotation.subtitle ?? "N/A"
        
        let message = """
        Title: \(titleText ?? "")
        Description: \(subtitleText ?? "")
        Latitude: \(annotation.coordinate.latitude)
        Longitude: \(annotation.coordinate.longitude)
        """
        
        let alert = UIAlertController.createInfoAlert(
            title: "Pinpoint Info",
            message: message
        )
        present(alert, animated: true)
    }

}

extension LocationDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewNoPinPointsAvailable.isHidden = viewModel.pinPoints.count > 0
        return viewModel.pinPoints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinPointTVC", for: indexPath) as! PinPointTVC
        let pinPoint = viewModel.pinPoints[indexPath.row]
        cell.loadPinDetails(pin: pinPoint)
        cell.btnDeletePinDetails.tag = indexPath.row
        cell.btnDeletePinDetails.addTarget(self, action: #selector(deleteDetails), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteDetails(_ sender: UIButton) {
        let index = sender.tag
        viewModel.deletePinPoint(at: index)
    }
}

