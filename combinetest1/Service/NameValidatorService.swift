//
//  NameValidatorService.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-02-01.
//

import Foundation

class NameValidatorService {
    func validateName(_ name: String?) async throws -> Bool{
        print("Name Validator Invokved. Thinking...")
        
        guard let name = name else {
            print("Name is null - NOT valid!")
            return false
        }
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Fake suppressor
        try await Task.sleep(for: .seconds(3))
        
        guard trimmed.count > 3 else {
            print("Name '\(name)' is NOT valid!")
            return false
        }
        
        print("Name '\(name)' is valid!")
        return true
    }
}
