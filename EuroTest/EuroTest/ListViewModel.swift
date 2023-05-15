//
//  ListViewModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

protocol DataSourceContract: AnyObject {
    var service: APIConfiguratorContract { get set }
    var dataList: APIResponse! { get set }
    func bindData(mocked: Bool)
}
final class ListViewModel: NSObject, DataSourceContract {
  
    var service: APIConfiguratorContract = APIConfigurator()
    var dataList: APIResponse!
    
    convenience init(for mocked: Bool) {
        self.init()
        self.bindData(mocked: mocked)
    }
    
    override init() {
        super.init()
        self.bindData(mocked: false)
    }
    
    func bindData(mocked: Bool) {
        Task.init(priority: .medium, operation: {
            do {
                try await service.fetchAllData(mocked: mocked, completion: { result in
                    switch result {
                    case .success(let payload):
                        self.dataList = payload
                    case .failure(let error):
                        dump(error)
                    }
                })
            } catch {
                print(error)
            }
        })
    }
}
