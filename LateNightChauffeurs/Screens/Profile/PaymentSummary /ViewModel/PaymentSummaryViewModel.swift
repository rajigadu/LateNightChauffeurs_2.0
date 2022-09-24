//
//  PaymentSummaryViewModel.swift
//  LateNightChauffeurs
//
//  Created by rajesh gandru on 24/09/22.
//

import Foundation
class PaymentSummaryViewModel: NSObject {
    
    private var PaymentSummaryServices: LateNightChauffeursUSERServiceProtocol
        
    init(ApiService: LateNightChauffeursUSERServiceProtocol = ApiService()) {
        self.PaymentSummaryServices = ApiService
    }
    
   
            
}

