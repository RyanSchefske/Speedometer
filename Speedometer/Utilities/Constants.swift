//
//  Constants.swift
//  Speedometer
//
//  Created by Ryan Schefske on 9/30/20.
//

import SwiftUI
import UIKit

enum Colors {
	static let darkGray = Color(.sRGB, red: 58/255, green: 58/255, blue: 60/255)
	static let darkishGray = Color(.sRGB, red: 68/255, green: 68/255, blue: 70/255)
	static let lightGray = Color("lightGray")
}

enum Gradients {
	static let tealGradient = Gradient(colors: [toRGB(r: 201, g: 247, b: 255), toRGB(r: 90, g: 200, b: 250)])
	static let redGradient = Gradient(colors: [toRGB(r: 237, g: 33, b: 58), toRGB(r: 147, g: 41, b: 30)])
	static let blueGradient = Gradient(colors: [toRGB(r: 102, g: 125, b: 182), toRGB(r: 0, g: 130, b: 200), toRGB(r: 0, g: 130, b: 200), toRGB(r: 102, g: 125, b: 182)])
	static let yellowGradient = Gradient(colors: [.white, toRGB(r: 255, g: 255, b: 0)])
	static let whiteGradient = Gradient(colors: [.white, toRGB(r: 233, g: 228, b: 240)])
	static let greenGradient = Gradient(colors: [toRGB(r: 67, g: 206, b: 162), toRGB(r: 24, g: 90, b: 157)])
	static let beachGradient = Gradient(colors: [Color(hex: "#70e1f5"), Color(hex: "#ffd194")])
	static let pinkGradient = Gradient(colors: [Color(hex: "#ee9ca7"), Color(hex: "#ffdde1")])
	static let peachGradient = Gradient(colors: [Color(hex: "#c6ffdd"), Color(hex: "#fbd786"), Color(hex: "#f7797d")])
	static let purpleGradient = Gradient(colors: [Color(hex: "#a8c0ff"), Color(hex: "#3f2b96")])
	static let sunsetGradient = Gradient(colors: [Color(hex: "#c06c84"), Color(hex: "#6c5b7b"), Color(hex: "#355c7d")])
	
	static let allModels: [ColorModel] = [.init(gradient: Gradients.tealGradient, name: "Teal", key: "teal"), .init(gradient: Gradients.redGradient, name: "Red", key: "red"), .init(gradient: Gradients.blueGradient, name: "Blue", key: "blue"), .init(gradient: Gradients.yellowGradient, name: "Yellow", key: "yellow"), .init(gradient: Gradients.whiteGradient, name: "White", key: "white"), .init(gradient: Gradients.greenGradient, name: "Green", key: "green"), .init(gradient: Gradients.beachGradient, name: "Beach", key: "beach"), .init(gradient: Gradients.pinkGradient, name: "Pink", key: "pink"), .init(gradient: Gradients.peachGradient, name: "Peach", key: "peach"), .init(gradient: Gradients.purpleGradient, name: "Purple", key: "lavender"), .init(gradient: Gradients.sunsetGradient, name: "Sunset", key: "sunset")]
}

enum Themes {
	static let original = "Original"
	static let classic = "Classic"
	static let wave = "Wave"
	
	static let allThemes: [Theme] = [.init(id: UUID(), theme: Themes.original), .init(id: UUID(), theme: Themes.classic), .init(id: UUID(), theme: Themes.wave)]
}

struct Theme {
	var id: UUID
	var theme: String
}

extension Gradients {
	static func toRGB(r: Double, g: Double, b: Double) -> Color {
		return Color(red: r / 255, green: g / 255, blue: b / 255)
	}
}

enum SFSymbols {
	//Side Menu Symbols
	static let gift = UIImage(systemName: "gift.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
	static let colors = UIImage(systemName: "circle.grid.hex.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
	static let map = UIImage(systemName: "map.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
	static let apps = UIImage(systemName: "app.badge.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
	static let lock = UIImage(systemName: "lock.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
	static let reset = UIImage(systemName: "shield.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.red)
	static let pencil = UIImage(systemName: "pencil.and.ellipsis.rectangle")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)

	static let location = UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
}

enum Measurements {
	static var measurements = ["mph", "km/h", "knots"]
}
