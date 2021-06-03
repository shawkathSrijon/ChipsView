//
//  ChipView.swift
//  ChipsView-SwiftUI
//
//  Created by Simec Sys Ltd. on 27/5/21.
//

import SwiftUI

struct ChipsDataModel: Identifiable {
    let id = UUID()
    @State var isSelected: Bool
    let titleKey: LocalizedStringKey
}

class ChipsViewModel: ObservableObject {
    @Published var dataObject: [ChipsDataModel] = [ChipsDataModel.init(isSelected: false, titleKey: "Apple")]
    
    func addChip() {
        dataObject.append(ChipsDataModel.init(isSelected: false, titleKey: "Blog(2130)"))
    }
    
    func removeLast() {
        guard dataObject.count != 0 else {
            return
        }
        dataObject.removeLast()
    }
}

struct ChipsContent: View {
    @ObservedObject var viewModel = ChipsViewModel()
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                ForEach(viewModel.dataObject) { chipsData in
                    Chips(titleKey: chipsData.titleKey, isSelected: chipsData.isSelected)
                        .padding(.all, 5)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            
                            let result = width
                            if chipsData.id == viewModel.dataObject.last!.id {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                          }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if chipsData.id == viewModel.dataObject.last!.id {
                                height = 0
                            }
                            return result
                        }
                }
            })
        }
        .padding(.all, 10)
    }
}

struct Chips: View {
    let titleKey: LocalizedStringKey
    @State var isSelected: Bool
    var body: some View {
        HStack {
            Text(titleKey)
                .font(.subheadline)
                .lineLimit(1)
                .foregroundColor(.white)
        }
        .padding(.all, 10)
        .background(isSelected ? Color.black.opacity(0.7) : Color.gray)
        .cornerRadius(8)
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//        )
        .onTapGesture {
            isSelected.toggle()
        }
    }
}
