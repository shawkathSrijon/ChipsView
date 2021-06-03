//
//  ContentView.swift
//  ChipsView-SwiftUI
//
//  Created by Simec Sys Ltd. on 27/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ChipsViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                ChipsContent(viewModel: viewModel)
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.removeLast()
                    }
                }) {
                    Image(systemName: "minus")
                }
                .frame(width: 50, height: 50)
                .background(Color.red.opacity(0.7))
                .clipShape(Circle())
                .foregroundColor(.white)
                Spacer()
                Button(action: {
                    withAnimation {
                        viewModel.addChip()
                    }
                }) {
                    Image(systemName: "plus")
                }
                .frame(width: 50, height: 50)
                .background(Color.green.opacity(0.7))
                .clipShape(Circle())
                .foregroundColor(.white)
                Spacer()
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
