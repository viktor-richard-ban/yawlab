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
    @Environment(\.appTheme) private var appTheme
    
    var body: some View {
        Menu {
            ForEach(options.indices, id: \.self) { (index: Int) in
                Button {
                    print("Option selected: \(options[index])")
                    didSelectOption(options[index])
                } label: {
                    Text(options[index])
                }
                .foregroundStyle(appTheme.designSystem.colors.text.primary)
            }
        } label: {
            Label(text, systemImage: "chevron.down")
                .foregroundStyle(appTheme.designSystem.colors.text.primary)
                .padding(8)
                .background(appTheme.designSystem.colors.background.panel)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(appTheme.designSystem.colors.background.borderSubtle)
                )
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
