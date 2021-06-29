//
//  DistanceView.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/6/20.
//

import SwiftUI

struct TopView: View {
	var header: String
	var value: String
	var measurement = PersistenceManager.shared.fetchMeasurement()
	
    var body: some View {
		ZStack {
			Circle()
				.frame(width: 100, height: 100, alignment: .center)
				.foregroundColor(Colors.lightGray)
				.shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 0)
			
			VStack(alignment: .center) {
				Text(header)
					.font(.system(size: 15))
				
				Text(value)
					.font(.system(size: 30))
				
				Text("\(measurement)")
					.font(.system(size: 15))
			}
			.padding(.all, 5)
		}
    }
}

struct DistanceView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			TopView(header: "Avg", value: "0.0", measurement: "mph")
		}
    }
}
