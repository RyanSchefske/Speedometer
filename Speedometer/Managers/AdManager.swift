//
//  AdManager.swift
//  Speedometer
//
//  Created by Ryan Schefske on 1/26/21.
//

import Foundation
import GoogleMobileAds

class AdManager: ObservableObject {
	@Published var interstitial = GADInterstitialAd()
}
