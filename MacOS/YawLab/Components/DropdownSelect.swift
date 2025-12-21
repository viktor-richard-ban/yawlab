//
//  Dropdown.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct DropdownSelect: View {
    let options: [String]
    let emptyText: String?
    @State var selectedOption: String? = nil
    
    var body: some View {
        Menu {
            ForEach(options.indices, id: \.self) { (index: Int) in
                Button {
                    print("Option selected: \(options[index])")
                    selectedOption = options[index]
                } label: {
                    Text(options[index])
                }
            }
        } label: {
            Label(selectedOption ?? "Select an option", systemImage: "chevron.down")
                .padding()
                .background(Color.black.opacity(0.1))
                .cornerRadius(8)
        }
        .menuStyle(.button)
        .buttonStyle(.plain)
    }
}

extension DropdownSelect {
    struct Option {
        let title: String
        let value: String
    }
}

#Preview {
    DropdownSelect(
        options: [
            "Norris",
            "Piastri"
        ],
        emptyText: "Select an option",
        selectedOption: nil
    )
}
