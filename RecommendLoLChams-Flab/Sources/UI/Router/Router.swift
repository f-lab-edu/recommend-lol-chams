//
//  Router.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 4/19/25.
//

import Foundation

final class Router: ObservableObject {
    static let shared = Router()
    
    @Published var path: [Route] = []
    
    init() {}
    
    func push(to route: Route) {
        Task { @MainActor in
            path.append(route)
        }
    }
    
    func pop(to k: Int = 1) {
        guard path.count >= k else { return }
        Task { @MainActor in
            path.removeLast(k)
        }
    }
    
    func popToRoot() {
        Task { @MainActor in
            path.removeAll()
        }
    }
}
