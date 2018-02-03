

import UIKit
import IGListKit

final class MatchSectionController: ListSectionController {
    var controller: UIViewController!
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        self.minimumInteritemSpacing = 0
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: appWidth - 20, height: 120)
    }
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCellFromStoryboard(withIdentifier: "MatchItemCell", for: self, at: index) as? MatchItemCell else {
            fatalError()
        }
        return cell
        
    }
    override func numberOfItems() -> Int {
        return 5
    }
    override func didUpdate(to object: Any) {
        
    }

    // MARK: ListAdapterDataSource

    override func didSelectItem(at index: Int) {
        if let con = mainStory.instantiateViewController(withIdentifier: "DetailsProfileVC") as? DetailsProfileVC{
            controller.navigationController?.pushViewController(con, animated: true)
        }
    }
}
