//
//  TimeStamp.swift
//  Speedometer
//
//  Created by Ryan Schefske on 1/31/21.
//

import SwiftUI

struct TimeStamp: Identifiable {
	var id = UUID()
	var time: Date
	var speed: CGFloat
}
