//
//  Dropdown.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct DropdownSelect: View {
    let options: [String]
    @Binding var text: String
    var didSelectOption: (String) -> Void
    
    var body: some View {
        Menu {
            ForEach(options.indices, id: \.self) { (index: Int) in
                Button {
                    print("Option selected: \(options[index])")
                    didSelectOption(options[index])
                } label: {
                    Text(options[index])
                }
                .foregroundStyle(.white)
            }
        } label: {
            Label(text, systemImage: "chevron.down")
                .foregroundStyle(.white)
                .padding(8)
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
        text: .constant("Select an option"),
        didSelectOption: {
            print("Option selected: \($0)")
        }
    )
}
