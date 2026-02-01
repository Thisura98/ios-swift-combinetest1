//
//  NameValidatorService.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-02-01.
//

import Foundation
import Combine

class NameValidatorService {
    func validateName(_ name: String?) async throws -> Bool{
        print("Name Validator Invokved. Thinking...")
        
        guard let name = name else {
            print("Name is null - NOT valid!")
            return false
        }
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmed.count > 3 else {
            print("Name '\(name)' is NOT valid!")
            return false
        }
        
        // Fake suppressor
        try await Task.sleep(for: .seconds(3))
        
        print("Name '\(name)' is valid!")
        return true
    }
    
    func validateNameV2(_ name: String?) -> Future<Bool, Never> {
        return Future { promise in
            Task{
                do{
                    promise(.success(try await self.validateName(name)))
                }
                catch(let error){
                    print("NameValidationService Error:", error)
                    promise(.success(false))
                }
            }
        }
    }
}
