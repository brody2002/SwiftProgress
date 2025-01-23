//
//  ContentView.swift
//  ActorsDemo
//
//  Created by Brody on 1/23/25.
//

import SwiftUI

actor BankAccount{
    var name: String
    var balance: Double
    init(name: String, balance: Double = 0.0) {
        self.name = name
        self.balance = balance
    }
    func deposit(_ input: Double) async {
         balance += input
    }
    func withdraw(_ input: Double) async {
        guard input > balance else {
            print("Withdrawing too much cash")
            return
        }
        balance -= input
    }
    func transfer(amount: Double, bankAccount: BankAccount) async {
        guard amount <= self.balance else {
            print("Not enough money in this account to transfer")
            return
        }
        await self.withdraw(amount)
        await bankAccount.deposit(amount)
        
    }
    func getBalance() -> Double{
        return self.balance
    }
}

struct ContentView: View {
    var body: some View {
        ZStack{
            Color(.white).ignoresSafeArea()
            VStack {
                Image(systemName: "dollarsign")
                    .resizable()
                    .imageScale(.large)
                    .foregroundStyle(.green)
                    .frame(width: 200, height: 300)
                Spacer().frame(height: 40)
                Text("Actors Example")
                    .fontWeight(.semibold)
            }
            .padding()
        }
        .onAppear{
            let accountA = BankAccount(name: "accountA", balance: 100)
            let accountB = BankAccount(name: "accountB", balance: 200)
            
            // NOTE:
            // We don't know the order of these tasks happening
            Task{
                await accountA.transfer(amount: 100, bankAccount: accountB)
                print("Blance of accountA \(await accountA.balance)")
                print("Blance of accountB \(await accountB.balance)")
            }
            Task{
                await accountA.transfer(amount: 110, bankAccount: accountB)
                print("Blance of accountA \(await accountA.balance)")
                print("Blance of accountB \(await accountB.balance)")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
