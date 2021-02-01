//
//  ProgressHUD.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

final public class ProgressHUD: UIView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [activityIndicator, label])
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        
        return stackView
    }()
    
    public init() {
        super.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        layer.cornerRadius = 20
        layer.shadowRadius = 2.5
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func show(_ view: UIView, text: String = "", for time: TimeInterval = .infinity) {
        
        view.addSubview(self)
        
        if !text.isEmpty {
            showWithText(view, text: text)
        } else {
            showSimple(view)
        }
        
        alpha = 0
        isHidden = false
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 1
        }
        
        guard time != .infinity else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + max(time - 0.5, 0)) { [weak self] in
            self?.hide()
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.alpha = 0
        } completion: { [weak self] (_) in
            self?.removeFromSuperview()
        }
    }
    
}

private extension ProgressHUD {
    func showWithText(_ view: UIView, text: String) {
        
        label.text = text
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 120),
            self.widthAnchor.constraint(equalToConstant: 184),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func showSimple(_ view: UIView) {
        
        self.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 80),
            self.widthAnchor.constraint(equalToConstant: 80),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
