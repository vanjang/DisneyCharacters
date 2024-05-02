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
    @State var state: ViewState<MainPageListViewItem> = .loading
    
    var body: some View {
        NavigationView {
          contentView
            .padding()
            .navigationTitle("Mixed List")
            .onAppear {
                print("onAppear")
                viewModel.load.send(())
            }
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.viewState {
           case .loading:
               LoadingView()
           case .empty:
               EmptyView()
           case .error(let message):
               ErrorView(message: message)
           case .ideal(let viewItem):
               OrthogonalListView(viewItem: viewItem)
                .environmentObject(dependencies)
           }
    }
    
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView(viewModel: MainPageViewModel(useCases: MainPageUseCases(repository: MainPageRepository(apiDataTransferService: NetworkDataTransferService(networkService: NetworkService()),
                                                                                                            localDataTransferService: LocalDataTransferService(localService: LocalDataService())))))
    }
}
