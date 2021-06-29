//
//  DistanceLabels.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/11/20.
//

import SwiftUI
import CoreLocation

struct DistanceLabels: View {
	var totalDistance: CLLocationDistance
	var tripDistance: CLLocationDistance
	
	var fullName = PersistenceManager.shared.fullName
	
    var body: some View {
		Text("\(totalDistance.convertDistance.roundedString1) \(fullName)")
			.font(.largeTitle)
			.fontWeight(.medium)
		
		Text("\(tripDistance.convertDistance.roundedString1) \(fullName)")
			.font(.system(size: 22))
			.foregroundColor(Color(UIColor.secondaryLabel))
    }
}

struct DistanceLabels_Previews: PreviewProvider {
    static var previews: some View {
		DistanceLabels(totalDistance: 10, tripDistance: 1)
    }
}
