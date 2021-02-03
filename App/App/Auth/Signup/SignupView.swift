//
//  SignupView.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

final class SignupView: BaseView {
    private lazy var nameTF: UITextField = {
        let view = UITextField()
        view.placeholder = "name"
        view.borderStyle = .roundedRect
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    private lazy var emailTF: UITextField = {
        let view = UITextField()
        view.placeholder = "email"
        view.borderStyle = .roundedRect
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    private lazy var passwordF: UITextField = {
        let view = UITextField()
        view.placeholder = "password"
        view.borderStyle = .roundedRect
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    private lazy var singupButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.backgroundColor = .black
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    @discardableResult
    public func setNameSelector(_ selector: Selector) -> SignupView {
        nameTF.addTarget(nil, action: selector, for: .allEditingEvents)
        return self
    }
    
    @discardableResult
    public func setEmailSelector(_ selector: Selector) -> SignupView {
        emailTF.addTarget(nil, action: selector, for: .allEditingEvents)
        return self
    }

    @discardableResult
    public func setPassSelector(_ selector: Selector) -> SignupView {
        passwordF.addTarget(nil, action: selector, for: .allEditingEvents)
        return self
    }
    
    @discardableResult
    public func setSignupSelector(_ selector: Selector) -> SignupView {
        singupButton.addTarget(nil, action: selector, for: .touchUpInside)
        return self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [nameTF, emailTF, passwordF, singupButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

