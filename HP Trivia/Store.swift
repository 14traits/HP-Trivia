//
//  Store.swift
//  HP Trivia
//
//  Created by John Rogers on 4/5/25.
//

import Foundation
import StoreKit

enum BookStatus {
    case active
    case inactive
    case locked
}

@MainActor
class Store: ObservableObject {
    @Published var books: [BookStatus] = [.active, .active, .inactive, .locked, .locked, .locked, .locked]
    @Published var products: [Product] = []
    @Published var purchasedIDs = Set<String>()
    
    private var productIDs = ["hp4", "hp5", "hp6", "hp7"]
    private var updates: Task<Void, Never>? = nil
    
    
    init() {
        updates = watchForUpdates()
    }
    
    func LoadProducts() async {
        do {
            products = try await Product.products(for: productIDs)
        } catch {
            print("Couldn't fetch those products: \(error)")
        }
    }
    
    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            
            switch result {
            
            // Purchase successful, but now we need to verify recipt
            case .success(let verificationResult):
                switch verificationResult {
                case .unverified(let signedType, let verficaitonError):
                    print("Error on \(signedType): \(verficaitonError)")
                    
                case .verified(let signedType):
                    purchasedIDs.insert(signedType.productID)
                }
                
            // User cancelled or parent disapproved child's purchase request
            case .userCancelled:
                break
                
            // Waiting for approval
            case .pending:
                break
            @unknown default:
                break
            }
        } catch {
            print("Coundn't complete purchase: \(error)")
        }
    }
    
    private func checkPurchased() async {
        for product in products {
            guard let state = await product.currentEntitlement else { return }
            
            switch state {
            case .unverified(let signedType, let verficaitonError):
                print("Error on \(signedType): \(verficaitonError)")
                
            case .verified(let signedType):
                if signedType.revocationDate == nil {
                    purchasedIDs.insert(signedType.productID)
                } else {
                    purchasedIDs.remove(signedType.productID)
                }
            }
        }
    }
    
    private func watchForUpdates() -> Task<Void, Never> {
        Task(priority: .background) {
            for await _ in Transaction.updates {
                await checkPurchased()
            }
        }
    }
}

