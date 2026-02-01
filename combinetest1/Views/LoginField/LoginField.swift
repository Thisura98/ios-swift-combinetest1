//
//  LoginField.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-01-06.
//
import UIKit

public class LoginField: NibLoadableView{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var onChange: ((_ text: String?) -> ())? = nil
    
    public enum IconName{
        case name
        case password
        
        func image() -> UIImage?{
            switch(self){
            case .name: return UIImage(systemName: "person.circle")!
            case .password: return UIImage(systemName: "lock.circle")!
            }
        }
    }
    
    public func setup(_ iconName: IconName? = nil, _ placeholder: String? = nil, _ text: String? = nil){
        if let iconName = iconName{
            imageView.image = iconName.image()
        }
        textField.placeholder = placeholder
        textField.text = text
        spinner.stopAnimating()
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        onChange?(textField.text)
    }
    
}
