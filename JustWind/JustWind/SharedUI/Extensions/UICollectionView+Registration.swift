import UIKit

extension UICollectionView {
    
    func registerNib<T: UICollectionViewCell>(_ nibClass: T.Type) {
        let nib = UINib(nibName: String(describing: T.self),
                        bundle: Bundle(for: T.self))
        register(nib, forCellWithReuseIdentifier: String(describing: nibClass))
    }
    
    func registerClass<T: UICollectionViewCell>(_ klass: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: klass))
    }
    
    func registerHeaderNib<T: UICollectionReusableView>(_ nibClass: T.Type) {
        registerNib(nibClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    func registerFooterNib<T: UICollectionReusableView>(_ nibClass: T.Type) {
        registerNib(nibClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
    }
    
    private func registerNib<T: UICollectionReusableView>(_ nibClass: T.Type,
                                                          forSupplementaryViewOfKind kind: String) {
        let nib = UINib(nibName: String(describing: T.self),
                        bundle: Bundle(for: T.self))
        register(nib,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: String(describing: nibClass))
    }
    
    func registerHeaderClass<T: UICollectionReusableView>(_ klass: T.Type) {
        register(klass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }
    
    func registerFooterClass<T: UICollectionReusableView>(_ klass: T.Type) {
        register(klass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
    }
    
    private func register<T: UICollectionReusableView>(_ klass: T.Type, forSupplementaryViewOfKind kind: String) {
        register(T.self,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: String(describing: klass))
        
    }
    
    //swiftlint:disable force_cast
    func dequeue<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self),
                                   for: indexPath) as! T
    }
    
    func dequeueHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeue(ofKind: UICollectionView.elementKindSectionHeader,
                       for: indexPath)
    }
    
    func dequeueFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        return dequeue(ofKind: UICollectionView.elementKindSectionFooter,
                       for: indexPath)
    }
    
    //swiftlint:disable force_cast
    private func dequeue<T: UICollectionReusableView>(ofKind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: ofKind,
                                                withReuseIdentifier: String(describing: T.self),
                                                for: indexPath) as! T
    }
}
