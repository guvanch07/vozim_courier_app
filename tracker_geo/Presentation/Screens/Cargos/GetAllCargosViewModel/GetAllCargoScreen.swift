//
//  GetAllCargoScreen.swift
//  tracker_geo
//
//  Created by Guvanch Amanov on 9.10.23.
//

import Foundation
import Combine

final class GetAllCargoViewModel: ObservableObject{
    
    @Published var listCargos:[Receipt] = []
    @Published private(set) var isRefreshing = false
    @Published var hasError = false
    @Published  var error: UserError?
    
    private let getAllcargoUseCase = GetAllCargoUseCase()
    
    func getAllCargos()  async {
        DispatchQueue.main.async{
            self.isRefreshing = true
        }
        do {
            let usecase = try await getAllcargoUseCase.execute()
            print(usecase.receipts[0].id)
            DispatchQueue.main.async{
                self.listCargos = usecase.receipts
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
