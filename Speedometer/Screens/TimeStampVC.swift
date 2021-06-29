//
//  TimeStampVC.swift
//  Speedometer
//
//  Created by Ryan Schefske on 1/31/21.
//

import SwiftUI

struct TimeStampVC: View {
	@ObservedObject var lm: LocationManager
	@Binding var showingTimeStampVC: Bool
	
	var body: some View {
		NavigationView {
			List(lm.timeStamps) { timeStamp in
				HStack {
					Text(timeStampString(timeStamp.time))
					Spacer()
					Text("\(timeStamp.speed.converted.roundedString1) \(PersistenceManager.shared.fetchMeasurement())")
				}
			}
			.navigationBarTitle("Speed Log")
			.navigationBarItems(leading:
				Text("\(Image(systemName: "chevron.left")) Back")
				.onTapGesture {
					showingTimeStampVC = false
				}
			)
		}
	}
	
	func timeStampString(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.timeStyle = .medium
		formatter.dateStyle = .short
		return formatter.string(from: date)
	}
}
