//
//  MainPageView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 30/04/2024.
//

import SwiftUI

struct MainPageView: View {
    // MARK: - Environment
    @EnvironmentObject private var dependencies: DependencyContainer
    
    // MARK: - Init
    @ObservedObject var viewModel: MainPageViewModel
    
    // MARK: - States
    @State var showAlert = false
    @State var showAlertSheet = false
    
    var body: some View {
        NavigationView {
            contentView
                .edgesIgnoringSafeArea([.bottom, .horizontal])
                .navigationBarTitle("Home", displayMode: .inline)
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Sort") {
                            showAlertSheet.toggle()
                        }
                        .actionSheet(isPresented: $showAlertSheet) {
                            let buttons = viewModel.sortTypes.map { t -> ActionSheet.Button in
                                    .default(Text(t.rawValue)) {
                                        viewModel.sortTap.send(t)
                                    }
                            } + [.cancel()]
                            return ActionSheet(title: Text("Select Sort Option"), buttons: buttons)
                        }
                    }
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
