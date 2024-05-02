//
//  DetailPageView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import SwiftUI

struct DetailPageView: View {
    @ObservedObject var viewModel: DetailPageViewModel
    
    @State var showAlert = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                RemoteImageView(url: viewModel.item?.imageUrl, isCircle: false, contentMode: .fit)
                
                Button((viewModel.item?.isFavorite ?? false) ? "Remove from favorites" : "Add to favorites") {
                    viewModel.didTapButton.send(())
                }
                
                Spacer()
            }
            .padding()
            
            if viewModel.isLoading {
                LoadingView()
            }
            
        }
        .navigationTitle(viewModel.item?.title ?? "Unknown")
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

struct DetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPageView(viewModel: DetailPageViewModel(id: 112, useCases: DetailPageUseCases(repository: DetailPageRepository(apiDataTransferService: NetworkDataTransferService(networkService: NetworkService()), localDataTransferService: LocalDataTransferService(localService: LocalDataService())))))
    }
}
