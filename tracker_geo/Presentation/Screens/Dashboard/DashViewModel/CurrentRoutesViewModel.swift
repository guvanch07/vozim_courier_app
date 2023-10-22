//
//  CurrentRoutesViewModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 8.08.23.
//

import Foundation

import Combine

final class CurrentRoutesViewModel: ObservableObject{
    
    //@Published var currentRoutes: CurrentResponseModel?
    @Published var listReceipts:[Receipt] = []
    @Published private(set) var isRefreshing = false
    @Published var hasError = false
    @Published  var error: UserError?
    @Published var isLoggedIn = false
    
    private let currentRoutesUseCase = CurrentRoutesUseCase()
    
    func getCurrentRoutes(tab: Int)  async {
        DispatchQueue.main.async{
            self.isRefreshing = true
        }
        do {
            let usecase = try await currentRoutesUseCase.execute(tab:tab)
            DispatchQueue.main.async{
                self.listReceipts = usecase.receipts
                self.isRefreshing = false
                self.isLoggedIn = true
            }
            print(usecase.receipts.map({ item in
                print("\(item.status)")
            }))
            UserDefaults.standard.set(usecase.id, forKey: "routeId")
        }catch{
            DispatchQueue.main.async{
                if let userErr = error as? UserError{
                    self.hasError = true
                    self.error = userErr
                    self.isRefreshing = false
                }
            }
        }
    }
}
