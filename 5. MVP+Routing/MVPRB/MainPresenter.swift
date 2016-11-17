//
//  Created by Pavel Sharanda on 17.11.16.
//  Copyright © 2016 psharanda. All rights reserved.
//

import Foundation

protocol MainPresenterDelegate: class {
    func showDetails(presenter: MainPresenter)
}

class MainPresenter {
    let textLoader: TextLoaderProtocol
    unowned let view: MainViewControllerProtocol    
    weak var delegate: MainPresenterDelegate?
    
    init(textLoader: TextLoaderProtocol, view: MainViewControllerProtocol) {
        self.textLoader = textLoader
        self.view = view
        
        self.view.delegate = self
    }
}

extension MainPresenter: MainViewControllerDelegate {
    
    func loadButtonClicked(view: MainViewControllerProtocol) {
        view.text = nil
        view.loading = true
        textLoader.loadText {
            view.loading = false
            view.text = $0
        }
    }
    
    func detailsClicked(view: MainViewControllerProtocol) {
        delegate?.showDetails(presenter: self)
    }
}
