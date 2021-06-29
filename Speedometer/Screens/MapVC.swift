//
//  MapVC.swift
//  Speedometer
//
//  Created by Ryan Schefske on 12/15/20.
//

import MapKit
import SwiftUI

struct MapVC: View {
	@Binding var showingMapVC: Bool
	@State private var centerCoordinate = CLLocationCoordinate2D()
	@ObservedObject var lm: LocationManager
	@State var measurement = PersistenceManager.shared.fetchMeasurement()
	@State var showRoute = 0
	
    var body: some View {
		ZStack {
			MapView(lm: lm, showRoute: $showRoute)
				.edgesIgnoringSafeArea(.all)
			
			VStack {
				HStack {
					Spacer()
					
					Picker(selection: $showRoute, label: Text("Show Route?")) {
						Image(systemName: "location.fill").tag(0)
						Image(systemName: "map.fill").tag(1)
					}
					.pickerStyle(SegmentedPickerStyle())
					.frame(width: 250, height: 30, alignment: .center)
					
					Spacer()
					
					Image(systemName: "xmark.circle.fill")
						.resizable()
						.frame(width: 45, height: 45)
						.gradientForeground(gradient: PersistenceManager.shared.fetchColor())
						.padding()
						.onTapGesture {
							showingMapVC = false
						}
				}
				
				Spacer()
				
				HStack {
					ZStack {
						Circle()
							.stroke(LinearGradient(gradient: PersistenceManager.shared.fetchColor(), startPoint: .bottomLeading, endPoint: .topTrailing), lineWidth: 3)
							.frame(width: 80, height: 80)
						
						VStack {
							Text("\(lm.speed.converted.roundedString)")
								.font(.title)
							
							Text(measurement)
								.font(.headline)
						}
						.padding()
					}
					.padding()
					Spacer()
				}
				.padding()
			}
		}
    }
}
