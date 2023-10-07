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
    
    @Published private(set) var isRefreshingStart = false
    
    private let currentRoutesUseCase = CurrentRoutesUseCase()
    private let startToWorkUseCase = StartToWorkUseCase()
    
    func getCurrentRoutes(tab: Int)  async {
        DispatchQueue.main.async{
            self.isRefreshing = true
        }
        do {
            let usecase = try await currentRoutesUseCase.execute(tab:tab)
            DispatchQueue.main.async{
                //self.currentRoutes = usecase
                self.listReceipts = usecase.receipts
                self.isRefreshing = false
                self.isLoggedIn = true
            }
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
    
    func startToWork(id:String) async -> SuccesResponse? {
        DispatchQueue.main.async{
            self.isRefreshingStart = true
        }
        do {
            let data = RouteWorkRequest(receipt: id, geo: GeoModel(lat: 23, lng: 43))
            let usecase = try await startToWorkUseCase.execute(startToWorkRequest: data)
            print(usecase)
            DispatchQueue.main.async{
                self.isRefreshingStart = false
            }
            return usecase
        }catch{
            DispatchQueue.main.async{
                if let userErr = error as? UserError{
                    self.hasError = true
                    self.error = userErr
                    self.isRefreshingStart = false
                }
            }
        }
        return nil
    }
}
