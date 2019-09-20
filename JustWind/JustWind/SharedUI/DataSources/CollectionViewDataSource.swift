import UIKit

class CollectionViewDataSource: NSObject {
    
    let collectionView: UICollectionView
    let sections: [CollectionSection]
    
    convenience init(collectionView: UICollectionView,
                     items: [CollectionItem]) {
        self.init(collectionView: collectionView,
                  sections: [GenericCollectionSection(items: items)])
    }
    
    init(collectionView: UICollectionView,
         sections: [CollectionSection]) {
        self.collectionView = collectionView
        self.sections = sections
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func item(indexPath: IndexPath) -> CollectionItem {
        return sections[indexPath.section].items[indexPath.item]
    }
}

extension CollectionViewDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].shouldSelect(item: indexPath.row)
    }
    
}

extension CollectionViewDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return sections[section].cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return item(indexPath: indexPath).cell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return sections[indexPath.section].didSelect(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let section = sections[indexPath.section]
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return section.headerView(collectionView: collectionView, indexPath: indexPath)
        case UICollectionView.elementKindSectionFooter:
            return section.footerView(collectionView: collectionView, indexPath: indexPath)
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplaySupplementaryView view: UICollectionReusableView,
                        forElementKind elementKind: String,
                        at indexPath: IndexPath) {
        view.layer.zPosition = 0.0
    }
    
}

class CollectionViewDataSourceFlowLayout: CollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return item(indexPath: indexPath).size(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return sections[section].headerSize(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return sections[section].footerSize(collectionView: collectionView)
    }
}
