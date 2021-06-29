//
//  ContentView.swift
//  Speedometer
//
//  Created by Ryan Schefske on 9/30/20.
//

import SwiftUI
import UIKit
import GoogleMobileAds

struct MeterVC: View {
	var body: some View {
		ZStack {
			Color(.tertiarySystemBackground).edgesIgnoringSafeArea(.all)
			Home()
		}
	}
}

struct MeterVC_Previews: PreviewProvider {
	static var previews: some View {
		MeterVC()
	}
}

struct Home: View {
	@ObservedObject var lm = LocationManager()
	@State var measurement = PersistenceManager.shared.fetchMeasurement()
	@State var fullName = PersistenceManager.shared.fullName
	@State var totalMiles = PersistenceManager.shared.fetchDistance()
	
	@State var menuOpen: Bool = false
	@State var isNavigationBarHidden: Bool = true
	@ObservedObject var adManager = AdManager()
	
	var body: some View {
		ZStack {
			VStack {
				HStack {
					MenuButton().onTapGesture(perform: {
						menuOpen.toggle()
					})
					
					Spacer()
					TopView(header: "Avg", value: lm.allSpeeds.average())
					Spacer()
					TopView(header: "Max", value: lm.allSpeeds.maximum)
				}.padding()
				
				Spacer()
				themeView()
				Spacer()
				
				DistanceLabels(totalDistance: lm.totalDistance, tripDistance: lm.tripDistance)
				
				Spacer()
				
				if !PersistenceManager.shared.fetchProUser() {
					InterstitialVC(adManager: adManager, lm: lm, menuOpen: $menuOpen)
						.frame(width: 0, height: 0)
					Banner()
				}
			}
			
			HStack {
				SideMenu(lm: lm)
					.offset(x: menuOpen ? 0 : -UIScreen.main.bounds.width)
					.animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.6))
					.opacity(menuOpen ? 1 : 0)
				
				Spacer(minLength: 15)
			}.background(
				Color.black.opacity(menuOpen ? 0.6 : 0)
					.edgesIgnoringSafeArea(.all)
					.onTapGesture(perform: {
						menuOpen.toggle()
					})
			)
		}
		.navigationBarTitle("")
		.navigationBarHidden(true)
		.gesture(DragGesture(minimumDistance: 1.0)
					.onEnded({ value in
						if value.translation.width > 0 {
							menuOpen = true
						}
					}))
		.onAppear {
			self.isNavigationBarHidden = true
		}
	}
	
	func themeView() -> AnyView {
		switch PersistenceManager.shared.fetchTheme() {
			case Themes.original:
				return AnyView(OldMeter(speed: lm.speed, direction: lm.direction))
			case Themes.classic:
				return AnyView(ClassicMeter(lm: lm, measurement: measurement))
			case Themes.wave:
				return AnyView(WaveMeter(speed: lm.speed, direction: lm.direction))
			default:
				return AnyView(OldMeter(speed: lm.speed, direction: lm.direction))
		}
	}
}

extension PersistenceManager {
	var fullName: String {
		let measurement = PersistenceManager.shared.fetchMeasurement()
		switch measurement {
			case "mph":
				return "miles"
			case "km/h":
				return "km"
			case "knots":
				return "nm"
			default:
				return "miles"
		}
	}
}

extension Array where Iterator.Element == CGFloat {
	func average() -> String {
		var total: CGFloat = 0
		for i in self { total += i }
		var average = total / CGFloat(self.count)
		average = average.converted
		return average.roundedString1
	}
	
	var maximum: String {
		var max: CGFloat = self.max() ?? 0.0
		max = max.converted
		return max.roundedString1
	}
}
