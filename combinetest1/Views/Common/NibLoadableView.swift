//
//  NibLoadableView.swift
//  combinetest1
//
//  Created by Thisura Dodangoda on 2026-01-06.
//
import UIKit

public class NibLoadableView: UIView{
    
    private var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.frame = frame
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(view)
        view.frame = self.bounds
    }
    
}
