//
//  ProfileContracts.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

protocol ProfileViewModelAction: AnyObject {
    func configureProfilePage()
    func showBanner(text: String)
}
