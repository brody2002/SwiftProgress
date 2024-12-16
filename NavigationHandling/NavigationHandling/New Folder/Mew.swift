import SwiftUI

struct tokens: View {
    @State private var searchText = ""
    @State private var selectedTokens: [SearchToken] = []
    @State private var allItems: [SearchItem] = [
        SearchItem(name: "Task 1", priority: "low", status: "open"),
        SearchItem(name: "Task 2", priority: "medium", status: "closed"),
        SearchItem(name: "Task 3", priority: "high", status: "open"),
        SearchItem(name: "Task 4", priority: "low", status: "closed"),
    ]
    
    var filteredItems: [SearchItem] {
        var filtered = allItems
        
        // Filter based on search text
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        
        // Filter based on selected tokens
        for token in selectedTokens {
            switch token.value {
            case "low", "medium", "high":
                filtered = filtered.filter { $0.priority == token.value }
            case "open", "closed":
                filtered = filtered.filter { $0.status == token.value }
            default:
                break
            }
        }
        
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            List(filteredItems) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text("Priority: \(item.priority.capitalized), Status: \(item.status.capitalized)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .searchable(text: $searchText, tokens: $selectedTokens, suggestedTokens: .constant([
                SearchToken(name: "Priority: Low", value: "low"),
                SearchToken(name: "Priority: Medium", value: "medium"),
                SearchToken(name: "Priority: High", value: "high"),
                SearchToken(name: "Status: Open", value: "open"),
                SearchToken(name: "Status: Closed", value: "closed")
            ])) { token in
                Label(token.name, systemImage: "tag")
            }
            .navigationTitle("Search Tasks")
        }
    }
}

// Example Token Struct
struct SearchToken: Identifiable {
    var id = UUID()
    var name: String
    var value: String
}

// Example Search Item Struct
struct SearchItem: Identifiable {
    var id = UUID()
    var name: String
    var priority: String
    var status: String
}

#Preview {
    tokens()
}

