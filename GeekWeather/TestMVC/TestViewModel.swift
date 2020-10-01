//
//  TestViewModel.swift
//  GeekWeather
//
//  Created by Mad Brains on 01.10.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import Foundation

class TestViewModel {
    
    private var authService: AuthService
    private var networkService: NetworkService
    
    private var data: Data?
    
    init(authService: AuthService, networkService: NetworkService) {
        self.authService = authService
        self.networkService = networkService
    }
    
    func auth() {
        
    }
    
    func loadData() {
//        networkService.fetch(resource: "", completion: {
//            data = result
//        })
    }
    
    func getData() -> Data? {
        return data
    }
    
}
