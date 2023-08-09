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
    
    private var currentRoutesUseCase = CurrentRoutesUseCase(
        repository: RepositoryImpl(apiService: ApiService())
        )

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
}
