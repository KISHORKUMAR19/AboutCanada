//
//  CountrySpecification.swift
//  AboutCanada
//
//  Created by Sateesh Yemireddi on 7/3/20.
//  Copyright © 2020 Company. All rights reserved.
//

import Foundation

class CountrySpecification {
    
    //MARK: - Properties
    
    private var specifications = [Specification]()
    var title = Dynamic<String>("")
    var dataFetchError = Dynamic<String?>(nil)
    var isDataFetched = Dynamic<Bool>(false)
    
    //MARK: - Init
    
    init(_ specifications: [Specification] = []) {
        self.specifications = specifications
    }
    
    //MARK: - Intent(s)
    var numberOfSpecifications: Int {
        return specifications.count
    }
    
    func specification(at indexpath:IndexPath) -> Specification {
        return specifications[indexpath.row]
    }
}

//MARK: - Data Fetching from API

extension CountrySpecification {
    func fetchData() {
        if let url = URL(string: EndPoint.url) {
            let urlRequest = URLRequest(url: url, method: .GET)
            APIClient(with: urlRequest).fetch(JSONResponse<[Specification]>.self) { result in
                self.isDataFetched.value = true
                switch result {
                case .success(let response):
                    self.title.value = response.title
                    self.specifications = response.specifications
                case .failure(let error):
                    self.dataFetchError.value = error.localizedDescription
                }
            }
        }
    }
}
