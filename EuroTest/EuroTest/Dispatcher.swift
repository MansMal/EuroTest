//
//  Dispatcher.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

protocol Dispatcher {
    func main (closure : @escaping () -> Swift.Void)
    func async (closure : @escaping () -> Swift.Void)
}
final class DefaultDispatcher: Dispatcher {

    func main(closure: @escaping () -> Swift.Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
    func async(closure: @escaping () -> Swift.Void) {
        DispatchQueue.global(qos: .background).async {
            closure()
        }
    }
}

extension Thread {

    static func runOnMain(block: @escaping (() -> Void)) {
        if Thread.isMainThread {
            return block()
        }
        DefaultDispatcher().main { block() }
    }
}
