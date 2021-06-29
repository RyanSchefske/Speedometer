//
//  Double+Ext.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/5/20.
//

import SwiftUI

extension CGFloat {
	var toMph: CGFloat { return self * 2.237 }
	var toKmh: CGFloat { return self * 3.6 }
	var toKnots: CGFloat { return self * 1.94384 }
	var roundedString: String { return String(format: "%.0f", self) }
	var roundedString1: String { return String(format: "%.1f", self) }
	
	var converted: CGFloat {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		switch measurement {
			case "mph":
				return self.toMph
			case "km/h":
				return self.toKmh
			case "knots":
				return self.toKnots
			default:
				return self.toMph
		}
	}
}
