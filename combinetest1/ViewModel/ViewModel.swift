//
//  MainViewModel.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-02-01.
//

import UIKit
import Combine

class ViewModel {
    
    @Published var name: String? = ""
    @Published var pw: String? = ""
    @Published var pwConfirm: String? = ""

    private let nameValidatorService = NameValidatorService()

    private var nameValidationState: AnyPublisher<(Bool, Bool), Never>?

    var validToSubmit: AnyPublisher<Bool, Never>? = Just(false).eraseToAnyPublisher()
    
    var nameIsLoading: AnyPublisher<Bool, Never>? = Just(false).eraseToAnyPublisher()

    public init(){
        // Build name validation state: emit (false, true) immediately when a new name arrives,
        // then emit (result, false) when the async validation completes
        nameValidationState = $name
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .removeDuplicates { $0 == $1 }
            .flatMap { [weak self] name -> AnyPublisher<(Bool, Bool), Never> in
                guard let self = self else { return Just((false, false)).eraseToAnyPublisher() }

                let result = Future<Bool, Never> { promise in
                    Task {
                        do {
                            let result = try await self.nameValidatorService.validateName(name)
                            promise(.success(result))
                        } catch {
                            print(error)
                            promise(.success(false))
                        }
                    }
                }

                // Start with loading state, then the final result
                return result
                    .map { ($0, false) }
                    .prepend((false, true))
                    .eraseToAnyPublisher()
            }
            .share() // We have two subscribers. If this wasn't there, the service is called twice.
            .eraseToAnyPublisher()
        
        nameIsLoading = nameValidationState?
            .map{ (_, isLoading) in isLoading }
            .removeDuplicates()
            .eraseToAnyPublisher()

        // Combine name validity and password confirmation. While name is loading, force false.
        validToSubmit = Publishers.CombineLatest3(nameValidationState!, $pw, $pwConfirm)
            .map { [weak self] nameState, pw, confirm in
                guard let self = self else { return false }
                let (isValidName, isLoadingName) = nameState
                return !isLoadingName && isValidName && self.validatePW(pw, confirm)
            }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    private func validatePW(_ first: String?, _ confirm: String?) -> Bool{
        guard let pw = first, let confirm = confirm else { return false }
        return pw == confirm
    }
    
}
