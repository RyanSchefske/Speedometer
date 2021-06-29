//
//  MapVC.swift
//  Speedometer
//
//  Created by Ryan Schefske on 12/15/20.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
	@ObservedObject var lm: LocationManager
	@Binding var showRoute: Int
	
	class Coordinator: NSObject, MKMapViewDelegate {
		var parent: MapView
		
		init(_ parent: MapView) {
			self.parent = parent
		}
		
		func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
			let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
			renderer.strokeColor = .systemTeal
			return renderer
		}
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView()
		mapView.delegate = context.coordinator
		mapView.userTrackingMode = .followWithHeading
		return mapView
	}
	
	func updateUIView(_ view: MKMapView, context: Context) {
		let allLocations = lm.allLocations
		let route = MKPolyline(coordinates: allLocations, count: allLocations.count)
		view.removeOverlays(view.overlays)
		view.addOverlay(route)
		
		if showRoute == 1 {
			let rect = route.boundingMapRect
			view.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
		} else {
			guard let region = lm.region else { return }
			view.setCamera(MKMapCamera(lookingAtCenter: region.center, fromDistance: 1000, pitch: 60, heading: lm.heading?.trueHeading ?? 0), animated: true)
		}
	}
}
