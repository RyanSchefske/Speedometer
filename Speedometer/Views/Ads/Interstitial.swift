//
//  AdInterstitialView.swift
//  Speedometer
//
//  Created by Ryan Schefske on 11/11/20.
//

import SwiftUI
import GoogleMobileAds
import UIKit

struct InterstitialVC: UIViewControllerRepresentable {
	@ObservedObject var adManager: AdManager
	@ObservedObject var lm: LocationManager
	@Binding var menuOpen: Bool
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		if lm.showInterstitial && !lm.isShowingAd {
			showInterstitial(uiViewController)
		} else if !lm.showInterstitial {
			if !menuOpen { uiViewController.dismiss(animated: true) }
		}
	}
	
	func showInterstitial(_ controller: UIViewController) {
		do {
			try adManager.interstitial.canPresent(fromRootViewController: controller)
			adManager.interstitial.present(fromRootViewController: controller)
			lm.isShowingAd = true
		} catch {}
	}
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let vc = UIViewController()
		vc.view.frame = UIScreen.main.bounds
		adManager.interstitial.fullScreenContentDelegate = context.coordinator
		return vc
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, GADFullScreenContentDelegate {
		var parent: InterstitialVC
		
		init(_ parent: InterstitialVC) {
			self.parent = parent
			super.init()
			createAndLoadInterstitial()
		}
		
		func createAndLoadInterstitial() {
			let request = GADRequest()
			GADInterstitialAd.load(withAdUnitID: Keys.interstitial, request: request) { [weak self] ad, error in
				guard
					error == nil,
					let ad = ad
				else { return }
				
				ad.fullScreenContentDelegate = self
				self?.parent.adManager.interstitial = ad
			}
		}
		
		func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
			parent.lm.showInterstitial = false
			parent.lm.isShowingAd = false
			createAndLoadInterstitial()
		}
	}
}
