//
//  View+Ext.swift
//  Speedometer
//
//  Created by Ryan Schefske on 10/5/20.
//

import SwiftUI

extension View {
	public func gradientForeground(gradient: Gradient) -> some View {
		self.overlay(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
			.mask(self)
	}
}
