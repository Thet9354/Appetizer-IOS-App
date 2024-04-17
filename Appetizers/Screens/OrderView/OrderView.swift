//
//  OrderView.swift
//  Appetizers
//
//  Created by Phoon Thet Pine on 9/4/24.
//

import SwiftUI

struct OrderView: View {
    
    @State private var orderItems = MockData.orderItems
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(orderItems) { appetizer in
                            AppetizerListCell(appetizer: appetizer)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button {
                        print("order Placed")
                    } label: {
                        APButton(title: "$99.99 - Place Order")
                    }
                    .padding(.bottom, 25)
                }
                
                if orderItems.isEmpty {
                    EmptyStates(imageName: "empty-order", message: "You have no items in your order.\nPlease add an appetizer!")
                }
            }
            .navigationTitle("Orders")
        }
    }
    
    func deleteItems(at offesets: IndexSet) {
        orderItems.remove(atOffsets: offesets)
    }
}

#Preview {
    OrderView()
}
