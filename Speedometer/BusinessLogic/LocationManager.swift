//
//  Accelerometer.swift
//  Speedometer
//
//  Created by Ryan Schefske on 9/30/20.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
	private let locationManager = CLLocationManager()
	let objectWillChange = PassthroughSubject<Void, Never>()
	var previousLocation: CLLocation? = nil
	
	var isStopped = false
	var stopCount = 0
	
	private let geocoder = CLGeocoder()
	
	@Published var status: CLAuthorizationStatus? { willSet { objectWillChange.send() } }
	@Published var location: CLLocation? { willSet { objectWillChange.send() } }
	@Published var speed: CGFloat = 0 { willSet { objectWillChange.send() } }
	@Published var placemark: CLPlacemark? = nil
	@Published var allSpeeds: [CGFloat] = [] { willSet { objectWillChange.send() } }
	@Published var direction: String = "N" { willSet { objectWillChange.send() } }
	@Published var tripDistance: CLLocationDistance = 0 { willSet { objectWillChange.send() } }
	@Published var allLocations: [CLLocationCoordinate2D] = [] { willSet { objectWillChange.send() } }
	@Published var region: MKCoordinateRegion? { willSet { objectWillChange.send() } }
	@Published var heading: CLHeading? { willSet { objectWillChange.send() } }
	@Published var timeStamps: [TimeStamp] = [] { willSet { objectWillChange.send() } }
	@Published var showInterstitial = false { willSet { objectWillChange.send() } }
	@Published var isShowingAd = false { willSet { objectWillChange.send() } }
	
	@Published var totalDistance: CLLocationDistance = PersistenceManager.shared.fetchDistance() {
		willSet {
			objectWillChange.send()
			PersistenceManager.shared.setDistance(distance: Double(totalDistance))
		}
	}
	
	override init() {
		super.init()
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestAlwaysAuthorization()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.startUpdatingHeading()
		locationManager.startUpdatingLocation()
	}
	
	private func geocode() {
		guard let location = self.location else { return }
		geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
			if error == nil {
				self.placemark = places?[0]
			} else {
				self.placemark = nil
			}
		})
	}
	
	private func checkSpeed() -> CGFloat {
		if location?.speed ?? 0 < 0 {
			return 0
		}
		return CGFloat(location?.speed ?? 0)
	}
	
	private func compassDirection(for heading: CLLocationDirection) -> String? {
		if heading < 0 { return nil }

		let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
		let index = Int((heading + 22.5) / 45.0) & 7
		return directions[index]
	}
	
	private func updateDistance() {
		guard let newLocation = locationManager.location?.coordinate else { return }
		
		if previousLocation == nil {
			previousLocation = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
		} else {
			guard let addedDistance = previousLocation?.distance(from: CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)) else { return }
			totalDistance += addedDistance
			tripDistance += addedDistance
			previousLocation = CLLocation(latitude: newLocation.latitude, longitude: newLocation.longitude)
		}
	}
}

extension LocationManager: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status != CLAuthorizationStatus.denied {
			locationManager.startUpdatingHeading()
			locationManager.startUpdatingLocation()
		} else {
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		self.location = location
		self.geocode()
		self.speed = checkSpeed()
		self.allSpeeds.append(self.speed)
		self.updateDistance()
		
		allLocations.append(location.coordinate)
		
		self.timeStamps.append(TimeStamp(time: Date(), speed: self.speed))
		
		let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
		self.region = region
		
		if self.speed == 0 && isStopped == false {
			stopCount += 1
			isStopped = true
		} else if self.speed != 0 && isStopped {
			isStopped = false
		}
		
		if self.speed == 0 && stopCount % 2 == 0 && isStopped {
			showInterstitial = true
		} else if isShowingAd {
			showInterstitial = false
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
		guard let direction = compassDirection(for: newHeading.trueHeading) else {
			self.direction = ""
			return
		}
		self.direction = direction
		self.heading = newHeading
	}
}
