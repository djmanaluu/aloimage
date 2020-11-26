//
//  ConstraintMaker.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class ConstraintMaker {
    enum DimensionType {
        case height
        case width
    }
    
    enum PositionType {
        case top
        case bottom
        case left
        case right
        case leading
        case trailing
        case centerX
        case centerY
        case center
        case edge
        case topSafeArea
        case bottomSafeArea
        case leftSafeArea
        case rightSafeArea
        case leadingSafeArea
        case trailingSafeArea
        case centerXSafeArea
        case centerYSafeArea
    }
    
    // MARK: - Properties
    
    lazy var top: PositionConstraint = PositionConstraint(currentView: currentView, type: .top)
    lazy var bottom: PositionConstraint = PositionConstraint(currentView: currentView, type: .bottom)
    lazy var left: PositionConstraint = PositionConstraint(currentView: currentView, type: .left)
    lazy var right: PositionConstraint = PositionConstraint(currentView: currentView, type: .right)
    lazy var leading: PositionConstraint = PositionConstraint(currentView: currentView, type: .leading)
    lazy var trailing: PositionConstraint = PositionConstraint(currentView: currentView, type: .trailing)
    lazy var centerX: PositionConstraint = PositionConstraint(currentView: currentView, type: .centerX)
    lazy var centerY: PositionConstraint = PositionConstraint(currentView: currentView, type: .centerY)
    lazy var edge: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .edge, previousTypes: [])
    lazy var center: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .center, previousTypes: [])
    
    lazy var width: DimensionConstraint = DimensionConstraint(currentView: currentView, type: .width)
    lazy var height: DimensionConstraint = DimensionConstraint(currentView: currentView, type: .height)
    lazy var size: MultipleDimensionConstraint = MultipleDimensionConstraint(currentView: currentView)
    
    private let currentView: UIView
    
    // MARK: - Init
    
    init(currentView: UIView) {
        self.currentView = currentView
    }
}

final class PositionConstraint {
    // MARK: - Properties
    
    lazy var top: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .top, previousTypes: [type])
    lazy var bottom: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .bottom, previousTypes: [type])
    lazy var left: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .left, previousTypes: [type])
    lazy var right: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .right, previousTypes: [type])
    lazy var leading: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .leading, previousTypes: [type])
    lazy var trailing: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .trailing, previousTypes: [type])
    lazy var centerX: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .centerX, previousTypes: [type])
    lazy var centerY: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .centerY, previousTypes: [type])
    
    private let currentView: UIView
    private let type: ConstraintMaker.PositionType
    
    // MARK: - Init
    
    fileprivate init(currentView: UIView, type: ConstraintMaker.PositionType) {
        self.currentView = currentView
        self.type = type
    }
    
    // MARK: - Public Methods
    
    /// Make constraint that equal to a constraint position in other view.
    ///
    /// - Parameter view: Brenchmark view
    /// - Parameter position: The brenchmark view's anchor position. Default value is nil and it will this method will refer same position with position from currentView.
    /// - Parameter constant: Constant
    @discardableResult
    func equalTo(_ view: UIView, position: ConstraintMaker.PositionType? = nil, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        
        switch type {
        case .top, .bottom, .topSafeArea, .bottomSafeArea, .centerY:
            if let position: ConstraintMaker.PositionType = position {
                constraint = getYAnchor(fromView: currentView, position: type).constraint(equalTo: getYAnchor(fromView: view, position: position), constant: constant)
            }
            else {
                constraint = getYAnchor(fromView: currentView, position: type).constraint(equalTo: getYAnchor(fromView: view, position: type), constant: constant)
            }
        case .left, .right, .leading, .trailing, .leftSafeArea, .rightSafeArea, .leadingSafeArea, .trailingSafeArea, .centerX:
            if let position: ConstraintMaker.PositionType = position {
                constraint = getXAnchor(fromView: currentView, position: type).constraint(equalTo: getXAnchor(fromView: view, position: position), constant: constant)
            }
            else {
                constraint = getXAnchor(fromView: currentView, position: type).constraint(equalTo: getXAnchor(fromView: view, position: type), constant: constant)

            }
        default:
            constraint = NSLayoutConstraint()
        }
        
        constraint.isActive = true
        
        return constraint
    }
    
    /// Make constraint that less than or equal to a constraint position in other view.
    ///
    /// - Parameter view: Brenchmark view
    /// - Parameter position: The brenchmark view's anchor position. Default value is nil and it will this method will refer same position with position from currentView.
    /// - Parameter constant: Constant
    @discardableResult
    func lessThanOrEqualTo(_ view: UIView, position: ConstraintMaker.PositionType? = nil, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        
        switch type {
        case .top, .bottom, .topSafeArea, .bottomSafeArea, .centerY:
            if let position: ConstraintMaker.PositionType = position {
                constraint = getYAnchor(fromView: currentView, position: type).constraint(lessThanOrEqualTo: getYAnchor(fromView: view, position: position), constant: constant)
            }
            else {
                constraint = getYAnchor(fromView: currentView, position: type).constraint(lessThanOrEqualTo: getYAnchor(fromView: view, position: type), constant: constant)
            }
        case .left, .right, .leading, .trailing, .leftSafeArea, .rightSafeArea, .leadingSafeArea, .trailingSafeArea, .centerX:
            if let position: ConstraintMaker.PositionType = position {
                constraint = getXAnchor(fromView: currentView, position: type).constraint(lessThanOrEqualTo: getXAnchor(fromView: view, position: position), constant: constant)
            }
            else {
                constraint = getXAnchor(fromView: currentView, position: type).constraint(lessThanOrEqualTo: getXAnchor(fromView: view, position: type), constant: constant)

            }
        default:
            constraint = NSLayoutConstraint()
        }
        
        constraint.isActive = true
        
        return constraint
    }
    
    /// Make constraint that greater than or equal to a constraint position in other view.
    ///
    /// - Parameter view: Brenchmark view
    /// - Parameter position: The brenchmark view's anchor position. Default value is nil and it will this method will refer same position with position from currentView.
    /// - Parameter constant: Constant
    @discardableResult
    func greaterThanOrEqualTo(_ view: UIView, position: ConstraintMaker.PositionType? = nil, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        
        switch type {
        case .top, .bottom, .topSafeArea, .bottomSafeArea, .centerY:
            if let position: ConstraintMaker.PositionType = position {
                constraint = getYAnchor(fromView: currentView, position: type).constraint(greaterThanOrEqualTo: getYAnchor(fromView: view, position: position), constant: constant)
            }
            else {
                constraint = getYAnchor(fromView: currentView, position: type).constraint(greaterThanOrEqualTo: getYAnchor(fromView: view, position: type), constant: constant)
            }
        case .left, .right, .leading, .trailing, .leftSafeArea, .rightSafeArea, .leadingSafeArea, .trailingSafeArea, .centerX:
            if let position: ConstraintMaker.PositionType = position {
                constraint = getXAnchor(fromView: currentView, position: type).constraint(greaterThanOrEqualTo: getXAnchor(fromView: view, position: position), constant: constant)
            }
            else {
                constraint = getXAnchor(fromView: currentView, position: type).constraint(greaterThanOrEqualTo: getXAnchor(fromView: view, position: type), constant: constant)

            }
        default:
            constraint = NSLayoutConstraint()
        }
        
        constraint.isActive = true
        
        return constraint
    }
    
    
    // MARK: - Private Mehtods
    
    private func getYAnchor(fromView view: UIView, position: ConstraintMaker.PositionType) -> NSLayoutYAxisAnchor {
        switch position {
        case .top:
            return view.topAnchor
        case .bottom:
            return view.bottomAnchor
        case .centerY:
            return view.centerYAnchor
        case .topSafeArea:
            return view.safeAreaLayoutGuide.topAnchor
        case .bottomSafeArea:
            return view.safeAreaLayoutGuide.bottomAnchor
        case .centerYSafeArea:
            return view.safeAreaLayoutGuide.centerYAnchor
        default:
            fatalError("Constraint position should be a vertical position (NSLayoutYAxisAnchor)!")
        }
    }
    
    private func getXAnchor(fromView view: UIView, position: ConstraintMaker.PositionType) -> NSLayoutXAxisAnchor {
        switch position {
        case .left:
            return view.leftAnchor
        case .right:
            return view.rightAnchor
        case .leading:
            return view.leadingAnchor
        case .trailing:
            return view.trailingAnchor
        case .centerX:
            return view.centerXAnchor
        case .leftSafeArea:
            return view.safeAreaLayoutGuide.leftAnchor
        case .rightSafeArea:
            return view.safeAreaLayoutGuide.rightAnchor
        case .leadingSafeArea:
            return view.safeAreaLayoutGuide.leadingAnchor
        case .trailingSafeArea:
            return view.safeAreaLayoutGuide.trailingAnchor
        case .centerXSafeArea:
            return view.safeAreaLayoutGuide.centerXAnchor
        default:
            fatalError("Constraint position should be a horizontal position (NSLayoutXAxisAnchor)!")
        }
    }
}

final class MultiplePositionConstraint {
    // MARK: - Properties
    
    lazy var top: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .top, previousTypes: positionTypes)
    lazy var bottom: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .bottom, previousTypes: positionTypes)
    lazy var left: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .left, previousTypes: positionTypes)
    lazy var right: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .right, previousTypes: positionTypes)
    lazy var leading: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .leading, previousTypes: positionTypes)
    lazy var trailing: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .trailing, previousTypes: positionTypes)
    lazy var centerX: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .centerX, previousTypes: positionTypes)
    lazy var centerY: MultiplePositionConstraint = MultiplePositionConstraint(currentView: currentView, currentType: .centerY, previousTypes: positionTypes)
    
    private let currentView: UIView
    private let positionTypes: [ConstraintMaker.PositionType]
    
    // MARK: - Init
    
    fileprivate init(currentView: UIView, currentType: ConstraintMaker.PositionType, previousTypes: [ConstraintMaker.PositionType]) {
        self.currentView = currentView
        self.positionTypes = previousTypes + [currentType]
    }
    
    // MARK: - Public Methods
    
    /// Make constraint equal to a view on multiple position.
    ///
    /// - Parameter view: The benchmark view
    /// - Parameter constant: Constant value
    @discardableResult
    func equalTo(_ view: UIView, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        for positionType in positionTypes {
            let constraint: NSLayoutConstraint
            
            switch positionType {
            case .top:
                constraint = currentView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
            case .bottom:
                constraint = currentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
            case .left:
                constraint = currentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant)
            case .right:
                constraint = currentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant)
            case .leading:
                constraint = currentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
            case .trailing:
                constraint = currentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
            case .topSafeArea:
                constraint = currentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            case .bottomSafeArea:
                constraint = currentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
            case .leftSafeArea:
                constraint = currentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: constant)
            case .rightSafeArea:
                constraint = currentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: constant)
            case .leadingSafeArea:
                constraint = currentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant)
            case .trailingSafeArea:
                constraint = currentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constant)
            case .centerX:
                constraint = currentView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
            case .centerY:
                constraint = currentView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
            case .centerXSafeArea:
                constraint = currentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: constant)
            case .centerYSafeArea:
                constraint = currentView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: constant)
            case .center:
                let centerXConstraint: NSLayoutConstraint = currentView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
                let centerYConstraint: NSLayoutConstraint = currentView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
                
                centerXConstraint.isActive = true
                centerYConstraint.isActive = true
                
                return [centerXConstraint, centerYConstraint]
            case .edge:
                let topConstraint: NSLayoutConstraint = currentView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
                let bottomConstraint: NSLayoutConstraint = currentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
                let leadingConstraint: NSLayoutConstraint = currentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant)
                let trailingConstraint: NSLayoutConstraint = currentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
                
                topConstraint.isActive = true
                bottomConstraint.isActive = true
                leadingConstraint.isActive = true
                trailingConstraint.isActive = true
                
                return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
            }
            
            constraint.isActive = true
            constraints.append(constraint)
        }
        
        return constraints
    }
    
    /// Make constraint less than or equal to a view on multiple position.
    ///
    /// - Parameter view: The benchmark view
    /// - Parameter constant: Constant value
    @discardableResult
    func lessThanOrEqualTo(_ view: UIView, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        for positionType in positionTypes {
            let constraint: NSLayoutConstraint
            
            switch positionType {
            case .top:
                constraint = currentView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: constant)
            case .bottom:
                constraint = currentView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: constant)
            case .left:
                constraint = currentView.leftAnchor.constraint(lessThanOrEqualTo: view.leftAnchor, constant: constant)
            case .right:
                constraint = currentView.rightAnchor.constraint(lessThanOrEqualTo: view.rightAnchor, constant: constant)
            case .leading:
                constraint = currentView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: constant)
            case .trailing:
                constraint = currentView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: constant)
            case .topSafeArea:
                constraint = currentView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            case .bottomSafeArea:
                constraint = currentView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
            case .leftSafeArea:
                constraint = currentView.leftAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: constant)
            case .rightSafeArea:
                constraint = currentView.rightAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: constant)
            case .leadingSafeArea:
                constraint = currentView.leadingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant)
            case .trailingSafeArea:
                constraint = currentView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constant)
            case .centerX:
                constraint = currentView.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant)
            case .centerY:
                constraint = currentView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant)
            case .centerXSafeArea:
                constraint = currentView.centerYAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor, constant: constant)
            case .centerYSafeArea:
                constraint = currentView.centerYAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor, constant: constant)
            case .center:
                let centerXConstraint: NSLayoutConstraint = currentView.centerXAnchor.constraint(lessThanOrEqualTo: view.centerXAnchor, constant: constant)
                let centerYConstraint: NSLayoutConstraint = currentView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: constant)
                
                centerXConstraint.isActive = true
                centerYConstraint.isActive = true
                
                return [centerXConstraint, centerYConstraint]
            case .edge:
                let topConstraint: NSLayoutConstraint = currentView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: constant)
                let bottomConstraint: NSLayoutConstraint = currentView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: constant)
                let leadingConstraint: NSLayoutConstraint = currentView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: constant)
                let trailingConstraint: NSLayoutConstraint = currentView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: constant)
                
                topConstraint.isActive = true
                bottomConstraint.isActive = true
                leadingConstraint.isActive = true
                trailingConstraint.isActive = true
                
                return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
            }
            
            constraint.isActive = true
            constraints.append(constraint)
        }
        
        return constraints
    }
    
    /// Make constraint greater than or equal to a view on multiple position.
    ///
    /// - Parameter view: The benchmark view
    /// - Parameter constant: Constant value
    @discardableResult
    func greaterThanOrEqualTo(_ view: UIView, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        for positionType in positionTypes {
            let constraint: NSLayoutConstraint
            
            switch positionType {
            case .top:
                constraint = currentView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: constant)
            case .bottom:
                constraint = currentView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: constant)
            case .left:
                constraint = currentView.leftAnchor.constraint(greaterThanOrEqualTo: view.leftAnchor, constant: constant)
            case .right:
                constraint = currentView.rightAnchor.constraint(greaterThanOrEqualTo: view.rightAnchor, constant: constant)
            case .leading:
                constraint = currentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: constant)
            case .trailing:
                constraint = currentView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: constant)
            case .topSafeArea:
                constraint = currentView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: constant)
            case .bottomSafeArea:
                constraint = currentView.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: constant)
            case .leftSafeArea:
                constraint = currentView.leftAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leftAnchor, constant: constant)
            case .rightSafeArea:
                constraint = currentView.rightAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.rightAnchor, constant: constant)
            case .leadingSafeArea:
                constraint = currentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constant)
            case .trailingSafeArea:
                constraint = currentView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: constant)
            case .centerX:
                constraint = currentView.centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant)
            case .centerY:
                constraint = currentView.centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant)
            case .centerXSafeArea:
                constraint = currentView.centerYAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor, constant: constant)
            case .centerYSafeArea:
                constraint = currentView.centerYAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.centerYAnchor, constant: constant)
            case .center:
                let centerXConstraint: NSLayoutConstraint = currentView.centerXAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor, constant: constant)
                let centerYConstraint: NSLayoutConstraint = currentView.centerYAnchor.constraint(greaterThanOrEqualTo: view.centerYAnchor, constant: constant)
                
                centerXConstraint.isActive = true
                centerYConstraint.isActive = true
                
                return [centerXConstraint, centerYConstraint]
            case .edge:
                let topConstraint: NSLayoutConstraint = currentView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: constant)
                let bottomConstraint: NSLayoutConstraint = currentView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: constant)
                let leadingConstraint: NSLayoutConstraint = currentView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: constant)
                let trailingConstraint: NSLayoutConstraint = currentView.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: constant)
                
                topConstraint.isActive = true
                bottomConstraint.isActive = true
                leadingConstraint.isActive = true
                trailingConstraint.isActive = true
                
                return [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
            }
            
            constraint.isActive = true
            constraints.append(constraint)
        }
        
        return constraints
    }
}

final class DimensionConstraint {
    // MARK: - Properties
    
    private let currentView: UIView
    private let type: ConstraintMaker.DimensionType
    
    // MARK: - Init
    
    fileprivate init(currentView: UIView, type: ConstraintMaker.DimensionType) {
        self.currentView = currentView
        self.type = type
    }
    
    // MARK: - Public Methods
    
    /// Make size constraint.
    ///
    /// - Parameter constant: Size's constant
    @discardableResult
    func equalToConstant(_ constant: CGFloat) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = getDimensionAnchor(fromView: currentView, position: type).constraint(equalToConstant: constant)
                
        constraint.isActive = true
        
        return constraint
    }
    
    /// Make size constraint.
    ///
    /// - Parameter view: The benchmark view
    /// - Parameter dimensionType: Dimension type
    /// - Parameter multiplier: Multiplier
    /// - Parameter constant: Constant
    @discardableResult
    func equalTo(_ view: UIView, dimensionType: ConstraintMaker.DimensionType? = nil, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        
        if let dimensionType: ConstraintMaker.DimensionType = dimensionType {
            constraint = getDimensionAnchor(fromView: currentView, position: type).constraint(equalTo: getDimensionAnchor(fromView: view, position: dimensionType),
                                                                                              multiplier: multiplier,
                                                                                              constant: constant)
            
        }
        else {
            constraint = getDimensionAnchor(fromView: currentView, position: type).constraint(equalTo: getDimensionAnchor(fromView: view, position: type), multiplier: multiplier, constant: constant)
        }
        
        constraint.isActive = true
        
        return constraint
    }
    
    // MARK: - Private Methods
    
    private func getDimensionAnchor(fromView view: UIView, position: ConstraintMaker.DimensionType) -> NSLayoutDimension {
        switch position {
        case .height:
            return view.heightAnchor
        case .width:
            return view.widthAnchor
        }
    }
}

final class MultipleDimensionConstraint {
    // MARK: - Properties
    
    private let currentView: UIView
    
    // MARK: - Init
    
    fileprivate init(currentView: UIView) {
        self.currentView = currentView
    }
    
    // MARK: - Public Methods
    
    /// Make size constraint.
    ///
    /// - Parameter constant: Size's constant
    @discardableResult
    func equalToConstant(_ constant: CGFloat) -> [NSLayoutConstraint] {
        let heightConstraint: NSLayoutConstraint = currentView.heightAnchor.constraint(equalToConstant: constant)
        let widthConstraint: NSLayoutConstraint = currentView.widthAnchor.constraint(equalToConstant: constant)
        
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        return [heightConstraint, widthConstraint]
    }
    
    /// Make size constraint.
    ///
    /// - Parameter view: The benchmark view
    /// - Parameter dimensionType: Dimension type
    /// - Parameter multiplier: Multiplier
    /// - Parameter constant: Constant
    @discardableResult
    func equalTo(_ view: UIView, multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) -> [NSLayoutConstraint] {
        let heightConstraint: NSLayoutConstraint = currentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: constant)
        let widthConstraint: NSLayoutConstraint = currentView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: constant)
        
        heightConstraint.isActive = true
        widthConstraint.isActive = true
        
        return [heightConstraint, widthConstraint]
    }
}
