//
//  BaseViewModelAction.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

protocol BaseViewModelAction: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func showErrorView(imageName: String,
                       description: String,
                       retryButtonLabel: String,
                       retryButtonAction: @escaping (() -> Void))
    func showNetworkError(retryButtonAction: @escaping (() -> Void))
    func hideErrorView()
}
