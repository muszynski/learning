//  ContentView.swift
//  FundacjaSantanderDesign
//
//  Created by Łukasz Muszyński on 17/05/2023.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTab = 0
//    @StateObject private var postService = PostService()
//    @StateObject private var categoryService = CategoriesService()
//    @State private var categoryMap: [Int16: String] = [:]
    
    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case 0:
                StartView()
            case 1:
                AktualnosciView()
            case 2:
                PomagajView()
            case 3:
                ProjektyView()
            default:
                FAQView()
            }
            Spacer()
            Divider()
                .overlay(Color("lightBlue"))
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    TabBarItem(icon: "start", title: "Start", isSelected: selectedTab == 0)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 0 }
                    TabBarItem(icon: "aktualnosci", title: "Aktualności", isSelected: selectedTab == 1)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 1 }
                    TabBarItem(icon: "pomagaj", title: "Pomagaj", isSelected: selectedTab == 2)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 2 }
                    TabBarItem(icon: "projekty", title: "Projekty", isSelected: selectedTab == 3)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 3 }
                    TabBarItem(icon: "faq", title: "FAQ", isSelected: selectedTab == 4)
                        .frame(width: geometry.size.width / 5)
                        .onTapGesture { selectedTab = 4 }
                }
            }.frame(height: 50)
            
        }
        //        .onAppear {
        //            DataService().fetchAndSavePosts()
        //            DataService().fetchAndSaveCategories()
        //            categoryMap = DataService().loadCategoriesFromCoreData()
        //        }
//        .onAppear {
//            categoryService.fetchCategories()
//                .sink(receiveCompletion: { completion in
//                    switch completion {
//                    case .failure(let error):
//                        print("Error fetching categories: \(error.localizedDescription)")
//                    case .finished:
//                        // Gdy skończy pobieranie kategorii, rozpocznij pobieranie postów
//                        postService.fetchAndSavePosts()
//                            .sink(receiveCompletion: { postCompletion in
//                                switch postCompletion {
//                                case .failure(let error):
//                                    print("Error fetching posts: \(error.localizedDescription)")
//                                case .finished:
//                                    categoryMap = categoryService.loadCategoriesFromCoreData()
//                                }
//                            }, receiveValue: { posts in
//                                // Tutaj możesz obsłużyć pobrane posty, jeśli jest to potrzebne
//                            })
//                            .store(in: &postService.cancellables)
//                    }
//                }, receiveValue: { categories in
//                    // Tutaj możesz obsłużyć pobrane kategorie, jeśli jest to potrzebne
//                })
//                .store(in: &categoryService.cancellables)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
