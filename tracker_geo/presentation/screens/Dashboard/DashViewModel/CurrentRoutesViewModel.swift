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
     
     

    func getCurrentRoutes()  async {
            DispatchQueue.main.async{
                self.isRefreshing = true
            }
            do {
                let usecase = try await currentRoutesUseCase.execute()
                DispatchQueue.main.async{
                    //self.currentRoutes = usecase
                    self.listReceipts = usecase.receipts
                    self.isRefreshing = false
                    self.isLoggedIn = true
                }
                
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
    
     func startToWork(id:String) async -> StartToWorkResponse? {
         DispatchQueue.main.async{
             self.isRefreshingStart = true
         }
         do {
             let data = StartToWorkRequest(receipt: id, geo: GeoModel(lat: 23, lng: 43))
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
