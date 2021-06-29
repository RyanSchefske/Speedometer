//
//  LineMeter.swift
//  Speedometer
//
//  Created by Ryan Schefske on 6/7/21.
//

import SwiftUI

struct LineMeter: View {
	
	@ObservedObject var lm = LocationManager()
	@State var measurement = PersistenceManager.shared.fetchMeasurement()
	
    var body: some View {
		VStack {
			ZStack {
				Circle()
					.frame(width: 10, height: 10)
					.gradientForeground(gradient: PersistenceManager.shared.fetchColor())
				
				Path { path in
					path.move(to: CGPoint(x: 100, y: 100))
					path.addLine(to: CGPoint(x: 100, y: 300))
					path.addLine(to: CGPoint(x: 300, y: 300))
				}
			}
		}
    }
}

struct LineMeter_Previews: PreviewProvider {
    static var previews: some View {
        LineMeter()
    }
}
