//
//  BaseViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension BaseViewController: BaseViewModelAction {
    func showLoadingView() {
        loadingView.show()
        
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func hideLoadingView() {
        loadingView.hide()
        loadingView.removeFromSuperview()
    }
    
    func showErrorView(imageName: String,
                       description: String,
                       retryButtonLabel: String,
                       retryButtonAction: @escaping () -> Void) {
        errorView.configureErrorView(imageName: imageName,
                                     description: description,
                                     retryButtonLabel: retryButtonLabel,
                                     retryButtonAction: retryButtonAction)
        
        view.addSubview(errorView)
        
        errorView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    func showNetworkError(retryButtonAction: @escaping (() -> Void)) {
        errorView.configureErrorView { [weak self] in
            guard let self: BaseViewController = self else { return }
            
            retryButtonAction()
            
            self.hideErrorView()
        }
        
        view.addSubview(errorView)
        
        errorView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view)
        }
    }
    
    func hideErrorView() {
        errorView.removeFromSuperview()
    }
}
