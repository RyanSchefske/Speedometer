//
//  WaveMeter.swift
//  Speedometer
//
//  Created by Ryan Schefske on 11/15/20.
//

import SwiftUI

struct Wave: Shape {

	var offset: Angle
	var percent: Double

	var animatableData: Double {
		get { offset.degrees }
		set { offset = Angle(degrees: newValue) }
	}

	func path(in rect: CGRect) -> Path {
		var p = Path()

		// empirically determined values for wave to be seen
		// at 0 and 100 percent
		let lowfudge = 0.02
		let highfudge = 0.98

		let newpercent = lowfudge + (highfudge - lowfudge) * percent
		let waveHeight = 0.015 * rect.height
		let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
		let startAngle = offset
		let endAngle = offset + Angle(degrees: 360)

		p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))

		for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
			let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
			p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
		}

		p.addLine(to: CGPoint(x: rect.width, y: rect.height))
		p.addLine(to: CGPoint(x: 0, y: rect.height))
		p.closeSubpath()

		return p
	}
}

struct WaveMeter: View {
	@State private var waveOffset = Angle(degrees: 0)
	
	var speed: CGFloat
	var direction: String
	var measurement = PersistenceManager.shared.fetchMeasurement()
	
	var body: some View {
		ZStack {
			Circle()
				.stroke(LinearGradient(gradient: PersistenceManager.shared.fetchColor(), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 10)
				.overlay(
					Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(speedPercent))
						.fill(LinearGradient(gradient: PersistenceManager.shared.fetchColor(), startPoint: .bottomLeading, endPoint: .topTrailing))
						.clipShape(Circle().scale(0.92))
				)
			
			VStack {
				Text(direction)
					.font(.system(size: 30, weight: .medium, design: .default))
				
				Text(speed.converted.roundedString)
					.font(.system(size: 90, weight: .medium, design: .default))
					.fontWeight(.medium)
				
				Text(measurement)
					.font(.system(size: 45, weight: .medium, design: .default))
					.padding(.top, -10)
			}
		}
		.aspectRatio(1, contentMode: .fit)
		.onAppear {
			withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
				self.waveOffset = Angle(degrees: 360)
			}
		}
		.frame(width: 280, height: 280, alignment: .center)
	}
	
	private var speedPercent: CGFloat {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		let speed = self.speed.converted
		var degrees: CGFloat = 0.15
		
		switch measurement {
			case "mph":
				degrees = speed / 100
			case "km/h":
				degrees = speed / 161
			case "knots":
				degrees = speed / 87
			default:
				degrees = speed / 100
		}
		return degrees
	}
}

struct WaveMeterCell: View {
	@State private var waveOffset = Angle(degrees: 0)
	
	var body: some View {
		GeometryReader { geo in
			ZStack {
				Circle()
					.stroke(LinearGradient(gradient: PersistenceManager.shared.fetchColor(), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 0.025 * min(geo.size.width, geo.size.height))
					.overlay(
						Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(45)/100)
							.fill(LinearGradient(gradient: PersistenceManager.shared.fetchColor(), startPoint: .bottomLeading, endPoint: .topTrailing))
							.clipShape(Circle().scale(0.92))
					)
				
				VStack {
					Text("N")
						.font(.system(size: 8, weight: .medium, design: .default))
					
					Text("45")
						.font(.system(size: 12, weight: .medium, design: .default))
						.fontWeight(.medium)
					
					Text("mph")
						.font(.system(size: 8, weight: .medium, design: .default))
						.padding(.top, -10)
				}
			}
		}
		.aspectRatio(1, contentMode: .fit)
		.onAppear {
			withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
				self.waveOffset = Angle(degrees: 360)
			}
		}
		.frame(width: 45, height: 50, alignment: .center)
	}
}

