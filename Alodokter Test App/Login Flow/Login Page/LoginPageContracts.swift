//
//  LoginPageContracts.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

protocol LoginPageViewModelAction: AnyObject {
    func handleUnauthorized()
    func login()
}
