//
//  Double+Ext.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/7/20.
//

import Foundation

extension Double {
	var roundedString1: String { return String(format: "%.1f", self) }
	
	var convertDistance: Double {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		switch measurement {
			case "mph":
				return self / 1609
			case "km/h":
				return self / 1000
			case "knots":
				return self / 1852
			default:
				return self / 1609
		}
	}
}
