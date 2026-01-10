//
//  ActiveModelView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 29..
//

import SwiftUI

struct ActiveModelView: View {
    let version: String
    let airDensity: String // "1.225 kg/m³"
    let regArea: String // "1.42 m²"
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text("ACTIVE MODEL")
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#359EFF"))
                Spacer()
                Text(version)
                    .padding(4)
                    .foregroundStyle(Color(hex: "#359EFF"))
                    .background(Color(red: 0.168, green: 0.259, blue: 0.338))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                    )
                    
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Air Denisity")
                        .foregroundStyle(.gray)
                    Text(airDensity)
                        .foregroundStyle(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Reg Area")
                        .foregroundStyle(.gray)
                    Text(regArea)
                        .foregroundStyle(.white)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color(hex: "#162128"))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(hex: "#233c48"), lineWidth: 2)
        )
    }
}

#Preview {
    ActiveModelView(version: "v2.4.1", airDensity: "1.225 kg/m³", regArea: "1.42 m²")
        .padding(16)
}
