//
//  DetailPageView.swift
//  DisneyCharacters
//
//  Created by myung hoon on 01/05/2024.
//

import SwiftUI

struct DetailPageView: View {
    @ObservedObject var viewModel: DetailPageViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPageView(viewModel: DetailPageViewModel(id: 112, useCases: DetailPageUseCases(repository: DetailPageRepository(apiDataTransferService: NetworkDataTransferService(networkService: NetworkService()), localDataTransferService: LocalDataTransferService(localService: LocalDataService())))))
    }
}
