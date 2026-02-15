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
    @Environment(\.theme) var theme
    
    var body: some View {
        Menu {
            ForEach(options.indices, id: \.self) { (index: Int) in
                Button {
                    print("Option selected: \(options[index])")
                    didSelectOption(options[index])
                } label: {
                    Text(options[index])
                        .font(theme.typography.label)
                }
                .foregroundStyle(theme.colors.textPrimary)
            }
        } label: {
            Label(text, systemImage: "chevron.down")
                .font(theme.typography.label)
                .foregroundStyle(theme.colors.textPrimary)
                .padding(8)
                .background(theme.colors.panel)
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
