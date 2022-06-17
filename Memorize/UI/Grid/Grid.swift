//
//  Grid.swift
//  Memorize
//
//  Created by Godwin A on 9/27/20.
//  Copyright © 2020 Godwin A. All rights reserved.
//

import SwiftUI

struct Grid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    var body: some View {
        GeometryReader { geometry in
            body(for: GridLayout(itemCount: items.count, in: geometry.size))
        }
    }
    
    // MARK: - Init
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    // MARK: - Private
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) { item in
            body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(where: { $0.id == item.id })!
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}

