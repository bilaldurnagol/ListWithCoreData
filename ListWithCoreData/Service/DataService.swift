//
//  DataService.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import Foundation
import Combine

class DataService {
    
    // MARK: - Properties
    static let shared = DataService()
    @Published var post: [Post] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Did finish load with error. \(error)")
                }
            } receiveValue: {[weak self] response in
                self?.post = response
            }
            .store(in: &cancellables)

    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
}
