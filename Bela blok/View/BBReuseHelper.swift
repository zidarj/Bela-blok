//
//  BBReuseHelper.swift
//  Bela blok
//
//  Created by Josip Zidar on 11/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewHeaderFooterView: ReusableView {}
extension UICollectionViewCell: ReusableView {}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
extension UITableViewHeaderFooterView: NibLoadableView {}
extension UICollectionViewCell: NibLoadableView {}

extension UITableView {
    
    func registerCellClass<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            print("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
            return T()
        }
        
        return cell
    }
    
    func registerHeaderFooterNib<T: UITableViewHeaderFooterView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            print("Could not dequeue header/footer view with identifier: \(T.defaultReuseIdentifier)")
            return T()
        }
        
        return headerFooterView
    }
    
}

extension UICollectionView {
    
    func registerCellClass<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            print("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
            return T()
        }
        
        return cell
    }
}
