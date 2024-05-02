//
//  MainPageView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject private var dependencies: DependencyContainer
    @ObservedObject var viewModel: MainPageViewModel
    
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            contentView
                .edgesIgnoringSafeArea([.bottom, .horizontal])
                .navigationBarTitle("Disney Characters", displayMode: .inline)
                .onLoad(perform: {
                    viewModel.load.send(())
                })
                .onReceive(viewModel.$error) { error in
                    if error != nil {
                        showAlert.toggle()
                    }
                }
                .alert(isPresented: $showAlert, error: viewModel.error) {
                    Button("OK") {}
                }
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        ZStack {
            if let item = viewModel.listItem {
                OrthogonalListView(viewItem: item) {
                    viewModel.load.send(())
                }
                .environmentObject(dependencies)
            } else {
                EmptyView()
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView(viewModel: MainPageViewModel(useCases: MainPageUseCases(repository: MainPageRepository(apiDataTransferService: NetworkDataTransferService(networkService: NetworkService()),
                                                                                                            localDataTransferService: LocalDataTransferService(localService: LocalDataService())))))
    }
}
