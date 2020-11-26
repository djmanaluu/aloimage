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
    
    var loadingView: LoadingStateView = LoadingStateView()
    
    var errorView: ErrorStateView = ErrorStateView()
    
    lazy var backButton: UIBarButtonItem = {
        let backButton: UIButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 24.0, height: 24.0))

        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.contentHorizontalAlignment = .left
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.setImage(UIImage(named: "ic-left-chevron"), for: .normal)

        return UIBarButtonItem(customView: backButton)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = false
        navigationItem.largeTitleDisplayMode = .never
        
        showBackButton(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Public Methods
    
    func showBackButton(_ show: Bool) {
        navigationItem.leftBarButtonItem = show ? backButton : nil
    }
    
    // MARK: - Button's Actions
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension BaseViewController: BaseViewModelAction {
    func showLoadingView() {
        loadingView.show()
        
        view.addSubview(loadingView)
        
        loadingView.makeConstraints { make in
            make.edge.equalTo(view)
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
        errorView.configureErrorView(retryButtonAction: retryButtonAction)
        
        view.addSubview(errorView)
        
        errorView.makeConstraints { make in
            make.top.left.right.bottom.equalTo(view)
        }
    }
    
    func showNetworkError(retryButtonAction: @escaping (() -> Void)) {
        errorView.configureErrorView { [weak self] in
            guard let self: BaseViewController = self else { return }
            
            retryButtonAction()
            
            self.hideErrorView()
        }
        
        view.addSubview(errorView)
        
        errorView.makeConstraints { make in
            make.top.left.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func hideErrorView() {
        errorView.removeFromSuperview()
    }
}
