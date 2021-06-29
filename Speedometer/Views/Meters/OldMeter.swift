//
//  OldMeter.swift
//  Speedometer
//
//  Created by Ryan Schefske on 9/30/20.
//

import SwiftUI

struct OldMeter: View {
	var speed: CGFloat
	var direction: String
	var measurement = PersistenceManager.shared.fetchMeasurement()
	
    var body: some View {
		ZStack {
			Circle()
				.trim(from: 0.15, to: 0.85)
				.rotation(.init(degrees: 90))
				.stroke(Colors.lightGray, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
				.frame(width: 280, height: 280)
				.shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 0)
			
			Circle()
				.trim(from: 0.15, to: speedDegrees)
				.rotation(.init(degrees: 90))
				.stroke(AngularGradient(gradient: PersistenceManager.shared.fetchColor(), center: .center, angle: .degrees(90)), style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
				.frame(width: 280, height: 280)
			
			VStack {
				Text(direction)
					.font(.system(size: 30, weight: .medium, design: .default))
					.gradientForeground(gradient: PersistenceManager.shared.fetchColor())
				
				Text("\(speed.converted.roundedString)")
					.font(.system(size: 90, weight: .medium, design: .default))
					.fontWeight(.medium)
				
				Text("\(measurement)")
					.font(.system(size: 45, weight: .medium, design: .default))
					.padding(.top, -10)
			}
		}
    }
	
	private var speedDegrees: CGFloat {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		let speed = self.speed.converted
		var degrees: CGFloat = 0.15
		
		switch measurement {
			case "mph":
				degrees = 0.15 + (speed * 0.7) / 100
			case "km/h":
				degrees = 0.15 + (speed * 0.7) / 161
			case "knots":
				degrees = 0.15 + (speed * 0.7) / 87
			default:
				degrees = 0.15 + (speed * 0.7) / 100
		}
		return degrees
	}
}

struct OldMeterCell: View {
	var body: some View {
		ZStack {
			Circle()
				.trim(from: 0.15, to: 0.85)
				.rotation(.init(degrees: 90))
				.stroke(Colors.lightGray, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
				.frame(width: 45, height: 45)
				.shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 0)
			
			Circle()
				.trim(from: 0.15, to: 0.40)
				.rotation(.init(degrees: 90))
				.stroke(AngularGradient(gradient: PersistenceManager.shared.fetchColor(), center: .center, angle: .degrees(90)), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
				.frame(width: 45, height: 45)
			
			VStack {
				Text("45")
					.font(.system(size: 8, weight: .medium, design: .default))
					.fontWeight(.medium)

				Text("mph")
					.font(.system(size: 8, weight: .medium, design: .default))
					.padding(.top, -10)
			}
		}
	}
}

struct OldMeter_Previews: PreviewProvider {
    static var previews: some View {
		OldMeterCell()
    }
}
