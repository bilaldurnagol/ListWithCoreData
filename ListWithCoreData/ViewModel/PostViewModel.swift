//
//  PostViewModel.swift
//  ListWithCoreData
//
//  Created by Bilal Durnagöl on 23.09.2022.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class PostViewModel: ObservableObject {
    
    @Published var posts: [Post] = dummyPost
    @Published var isLoading: Bool = false
    @Published var state: ViewState = .loading
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = DataService.shared
 
    var localeStorage = LocaleStorage.shared
    
    init() {
        fetchToData()
    }
    
    func fetchToData() {
        if let requests = localeStorage.get(withID: POST_CORE_DATA_KEY), let response = requests.responseBody?.asDecodable(type: [Post].self) {
            state = .locale
            posts = response
        }
        
        isLoading = state == .loading
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {[weak self] in
            guard let strongSelf = self else {return}
            self?.dataService.$post
                .sink {[weak self] model in
                    if self?.state == .loading {
                        self?.posts = model
                    } else if self?.state == .locale {
                        self?.posts.insert(contentsOf: model, at: 0)
                    }
                    
                    self?.saveToLocale(response: model)
                    self?.isLoading = false
                }
                .store(in: &strongSelf.cancellables)
            self?.state = .finish
        }
    }
    
    
    func saveToLocale(response: [Post]) {
        let requests = LocaleStorage.Request(id: POST_CORE_DATA_KEY, responseBody: response.asData, requestBody: nil)
        localeStorage.save(request: requests)
    }
}

extension Encodable {
    var asData: Data? {
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        return data
    }
}

extension Data {
    func asDecodable<T: Decodable>(type: T.Type) -> T? {
        let decoded = try? JSONDecoder().decode(T.self, from: self)
        return decoded
    }
}
