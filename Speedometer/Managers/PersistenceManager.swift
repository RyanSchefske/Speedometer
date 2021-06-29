//
//  PersistenceManager.swift
//  Speedometer
//
//  Created by Ryan Schefske on 9/30/20.
//

import SwiftUI

class PersistenceManager {
	
	private let defaults = UserDefaults.standard
	static let shared = PersistenceManager()
	
	enum Keys {
		static let measurement = "Measurement"
		static let distance = "Distance"
		static let color = "Color"
		static let proUser = "ProUser"
		static let theme = "Theme"
	}
	
	func fetchMeasurement() -> String {
		if let measurement = defaults.string(forKey: Keys.measurement) {
			return measurement
		}
		return "mph"
	}
	
	func setMeasurement(type: String) {
		defaults.set(type, forKey: Keys.measurement)
	}
	
	func fetchDistance() -> Double {
		let distance = defaults.double(forKey: Keys.distance)
		return distance
	}
	
	func setDistance(distance: Double) {
		defaults.set(distance, forKey: Keys.distance)
	}
	
	func fetchColor() -> Gradient {
		guard let color = defaults.string(forKey: Keys.color) else { return Gradients.tealGradient }
		
		switch color {
			case "teal": return Gradients.tealGradient
			case "red": return Gradients.redGradient
			case "blue": return Gradients.blueGradient
			case "yellow": return Gradients.yellowGradient
			case "green": return Gradients.greenGradient
			case "white": return Gradients.whiteGradient
			case "pink": return Gradients.pinkGradient
			case "lavender": return Gradients.purpleGradient
			case "beach": return Gradients.beachGradient
			case "peach": return Gradients.peachGradient
			case "sunset": return Gradients.sunsetGradient
			default: return Gradients.tealGradient
		}
	}
	
	func setColor(to color: String) {
		defaults.set(color, forKey: Keys.color)
	}
	
	func fetchTheme() -> String {
		guard let theme = defaults.string(forKey: Keys.theme) else { return Themes.original }
		return theme
	}
	
	func setTheme(to theme: String) {
		defaults.set(theme, forKey: Keys.theme)
	}
	
	func fetchProUser() -> Bool {
		#if DEBUG
		return false
		#else
		return defaults.bool(forKey: Keys.proUser)
		#endif
	}
	
	func setProUser(to bool: Bool) {
		defaults.set(bool, forKey: Keys.proUser)
	}
	
	func reset() {
		defaults.removeObject(forKey: Keys.proUser)
	}
}
