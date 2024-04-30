//
// Created by John Griffin on 4/30/24
//

import SwiftUI
import UIKit

#Preview("CSS BASIC") {
    List {
        Section("Basic") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(UIColor.CSS.Basic.allCases, id: \.self) { c in
                    Color(uiColor: c.uiColor)
                        .aspectRatio(1.67, contentMode: .fill)
                        .overlay(
                            Text(c.name)
                        )
                }
            }
        }
    }
}

#Preview("CSS Extended") {
    List {
        Section("Extended") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(UIColor.CSS.Extended.allCases, id: \.self) { c in
                    Color(uiColor: c.uiColor)
                        .aspectRatio(1.67, contentMode: .fill)
                        .overlay(
                            Text(c.name)
                        )
                }
            }
        }
    }
}

#Preview("ColorPalettes") {
    HStack(spacing: 20) {
        VStack(alignment: .leading) {
            Text("Categoricals").font(.title)
            ForEach(ColorPalette.Categorical.palettes, id: \.name) { palette in
                Text(palette.name)
                HStack(spacing: 2) {
                    ForEach(palette.uiColors, id: \.self) { uiColor in
                        Color(uiColor: uiColor)
                    }
                }
            }
        }

        VStack(alignment: .leading) {
            Text("Sequentials").font(.title)
            ForEach(ColorPalette.Sequential.palettes, id: \.name) { palette in
                Text(palette.name)
                HStack(spacing: 2) {
                    ForEach(palette.uiColors, id: \.self) { uiColor in
                        Color(uiColor: uiColor)
                    }
                }
            }
        }
        VStack(alignment: .leading) {
            Text("Divergings").font(.title)
            ForEach(ColorPalette.Divergent.palettes, id: \.name) { palette in
                Text(palette.name)
                HStack(spacing: 2) {
                    ForEach(palette.uiColors, id: \.self) { uiColor in
                        Color(uiColor: uiColor)
                    }
                }
            }
        }
    }
}
