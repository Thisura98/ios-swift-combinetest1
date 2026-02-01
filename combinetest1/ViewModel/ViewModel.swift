//
//  MainViewModel.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-02-01.
//

import Combine

class ViewModel{
    
    @Published var name: String? = nil
    @Published var pw: String? = nil
    @Published var pwConfirm: String? = nil
    
    var validToSubmit: AnyPublisher<Bool, Never>? = nil
    
    public init(){
        validToSubmit = Publishers.CombineLatest3($name, $pw, $pwConfirm)
            .map{ [weak self] name, pw, confirm in
                guard let self = self else { return false }
                return self.validateName(name) && self.validatePW(pw, confirm)
            }.eraseToAnyPublisher()
    }
    
    private func validateName(_ value: String?) -> Bool{
        guard let name = value else { return false }
        return name.count >= 3
    }
    
    private func validatePW(_ first: String?, _ confirm: String?) -> Bool{
        guard let pw = first, let confirm = confirm else { return false }
        return pw == confirm
    }
    
}
