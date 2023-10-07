//
//  DetailViewModel.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 7.10.23.
//

import Foundation

import Combine

final class DetailViewModel: ObservableObject{
    
    @Published private(set) var isLoading = false
    @Published var hasError = false
    @Published  var error: UserError?
    @Published var startToWorkSucces: SuccesResponse?
    private let startToWorkUseCase = StartToWorkUseCase()
    
    func startToWork(id:String) async -> SuccesResponse? {
            DispatchQueue.main.async{self.isLoading = true}
            do {
                let data = RouteWorkRequest(receipt: id, geo: GeoModel(lat: 23, lng: 43))
                let usecase = try await startToWorkUseCase.execute(startToWorkRequest: data)
                print(usecase)
                DispatchQueue.main.async{
                    self.startToWorkSucces = usecase
                    self.isLoading = false
                }
                return usecase
            }catch{
                DispatchQueue.main.async{
                    if let userErr = error as? UserError{
                        self.hasError = true
                        self.error = userErr
                        self.isLoading = false
                    }
                }
            }
            return nil
    }
}

