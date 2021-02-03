//
//  LoginView.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

final class LoginView: BaseView {
    
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
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.backgroundColor = .clear
        button.setTitle("Signup", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    @discardableResult
    public func setEmailSelector(_ selector: Selector) -> LoginView {
        emailTF.addTarget(nil, action: selector, for: .allEditingEvents)
        return self
    }
    
    @discardableResult
    public func setPassSelector(_ selector: Selector) -> LoginView {
        passwordF.addTarget(nil, action: selector, for: .allEditingEvents)
        return self
    }
    
    @discardableResult
    public func setSignupSelector(_ selector: Selector) -> LoginView {
        loginButton.addTarget(nil, action: selector, for: .touchUpInside)
        return self
    }
    
    @discardableResult
    public func setRegisterSelector(_ selector: Selector) -> LoginView {
        registerButton.addTarget(nil, action: selector, for: .touchUpInside)
        return self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let stackView = UIStackView(arrangedSubviews: [emailTF, passwordF, loginButton, registerButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 24
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            //stackView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
