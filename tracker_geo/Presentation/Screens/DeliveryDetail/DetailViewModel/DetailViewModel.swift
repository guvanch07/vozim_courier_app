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
    @Published var arrivedDataSucces: SuccesResponse?
    
    
    private let startToWorkUseCase = StartToWorkUseCase()
    private let arrivedAddress = ArrivedToAddressUseCase()
    
    func startToWork(id:String,geo:GeoModel) async -> SuccesResponse? {
        do {
            let data = RouteWorkRequest(receipt: id, geo: geo)
            let usecase = try await startToWorkUseCase.execute(startToWorkRequest: data)
            print(usecase)
            DispatchQueue.main.async{
                self.startToWorkSucces = usecase
            }
            return usecase
        }catch{
            DispatchQueue.main.async{
                if let userErr = error as? UserError{
                    self.hasError = true
                    self.error = userErr
                }
            }
        }
        return nil
    }
    
    func arrivedToAddress(id:String) async -> SuccesResponse? {
        do {
            let data = RouteWorkRequest(receipt: id, geo: GeoModel(lat: 32.323, lng: 34.434))
            let usecase = try await arrivedAddress.execute(arrivedRequest: data)
            print(usecase)
            DispatchQueue.main.async{
                self.arrivedDataSucces = usecase
            }
            return usecase
        }catch{
            DispatchQueue.main.async{
                if let userErr = error as? UserError{
                    self.hasError = true
                    self.error = userErr
                }
            }
        }
        return nil
    }
}

