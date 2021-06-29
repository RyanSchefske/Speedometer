//
//  ClassicMeter.swift
//  Speedometer
//
//  Created by Ryan Schefske on 9/30/20.
//

import SwiftUI

struct ClassicMeter: View {
	@ObservedObject var lm = LocationManager()
	@State var measurement = PersistenceManager.shared.fetchMeasurement()
	
	var body: some View {
		VStack {
			Text(lm.direction)
				.font(.system(size: 30, weight: .medium, design: .default))
				.gradientForeground(gradient: PersistenceManager.shared.fetchColor())
				.padding(.bottom, 10)
			
			ZStack {
				ZStack {
					Circle()
						.trim(from: 0, to: 0.5)
						.stroke(Colors.lightGray, lineWidth: 55)
						.frame(width: 280, height: 280)
						.shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 0)
					
					Circle()
						.trim(from: 0, to: setSpeed())
						.stroke(AngularGradient(gradient: PersistenceManager.shared.fetchColor(), center: .center, angle: .degrees(180)), lineWidth: 55)
						.frame(width: 280, height: 280)
				}
				.rotationEffect(.init(degrees: 180))
				
				ZStack(alignment: .bottom) {
					Color.red
						.frame(width: 2, height: 95)
					
					Circle()
						.fill(Color.red)
						.frame(width: 15, height: 15)
				}
				.offset(y: -35)
				.rotationEffect(.init(degrees: -90))
				.rotationEffect(.init(degrees: self.setArrow()))
			}
			.padding(.bottom, -130)
			.padding(.top, 25)
			
			Text("\(lm.speed.converted.roundedString) \(measurement)")
				.font(.system(size: 40, weight: .medium, design: .default))
				.padding(.top, 5)
		}
	}
	
	func setSpeed() -> CGFloat {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		let speed = lm.speed.converted
		var degrees: CGFloat = 0
		
		switch measurement {
			case "mph":
				degrees = (speed * 0.5) / 100
			case "km/h":
				degrees = (speed * 0.5) / 161
			case "knots":
				degrees = (speed * 0.5) / 87
			default:
				degrees = (speed * 0.5) / 100
		}
		return degrees
	}
	
	func setArrow() -> Double {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		let speed = lm.speed.converted
		var degrees: CGFloat = 0
		
		switch measurement {
			case "mph":
				degrees = (speed) / 100
			case "km/h":
				degrees = (speed) / 161
			case "knots":
				degrees = (speed) / 87
			default:
				degrees = (speed) / 100
		}
		return Double(degrees * 180)
	}
}

struct ClassicMeterCell: View {
	var body: some View {
		VStack {
			ZStack {
				ZStack {
					Circle()
						.trim(from: 0, to: 0.5)
						.stroke(Colors.lightGray, lineWidth: 20)
						.frame(width: 40, height: 40)
						.shadow(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 0)
					
					Circle()
						.trim(from: 0, to: 0.20)
						.stroke(AngularGradient(gradient: PersistenceManager.shared.fetchColor(), center: .center, angle: .degrees(180)), lineWidth: 20)
						.frame(width: 40, height: 40)
				}
				.rotationEffect(.init(degrees: 180))
				
				ZStack(alignment: .bottom) {
					Color.red
						.frame(width: 2, height: 27)
					
					Circle()
						.fill(Color.red)
						.frame(width: 7, height: 7)
				}
				.offset(y: -13)
				.rotationEffect(.init(degrees: -90))
				.rotationEffect(.init(degrees: 72))
			}
			.padding(.bottom, -25)
			.padding()
		}
	}
}

struct ClassicMeter_Previews: PreviewProvider {
	static var previews: some View {
		ClassicMeter(lm: LocationManager(), measurement: "mph")
	}
}
