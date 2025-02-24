//
//  AnalyticsService.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import Foundation
import AppMetricaCore


enum AnalyticsServiceError: Error {
    case createReporterError
}


final class AnalyticsService {
    private static let API_KEY = "324fc1f2-5cc4-4691-9220-2f215001247e"
    static let shared = AnalyticsService()
    
    private init() {}
    
    static func activate() {
        guard let configuration = AppMetricaConfiguration(apiKey: AnalyticsService.API_KEY) else { return }
        
        AppMetrica.activate(with: configuration)
    }
    
    func trackEvent(event: AnalyticsEvent, params: [AnyHashable : Any]) {
        guard let reporter = AppMetrica.reporter(for: AnalyticsService.API_KEY) else {
            Log.error(error: AnalyticsServiceError.createReporterError, message: "failed to create reporter")
            return
        }
        reporter.resumeSession()
        
        reporter.reportEvent(name: event.rawValue, parameters: params, onFailure: { error in
            Log.error(error: error, message: "failed to report event")
        })
        
        reporter.pauseSession()
    }
}
