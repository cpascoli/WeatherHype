//
//  WeatherDataPageViewController.swift
//  WeatherHype
//
//  Created by Carlo Pascoli on 28/09/2016.
//  Copyright © 2016 Carlo Pascoli. All rights reserved.
//

import UIKit

class WeatherDataPageViewController: UIPageViewController {

    var apiClient:APIClient!
    var model:[WeatherData]! {
        didSet {
            setupUI()
        }
    }
    
    var weatherViewControllerArray:[WeatherViewController]!

    // delegate used to inform the CityViewContoller that a new day is being presented
    weak var pageChangedDelegate:WeatherDataChangedDelegate?
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]?) {
        super.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
 
    }
    
    func setupUI() {
    
        setupViewControllers(with:self.model)
        
        if let firstController = self.weatherViewControllerArray.first {
            setViewControllers([firstController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
            
        }
        
        self.dataSource = self
        self.delegate = self
        
        // notify the delegate to update the day
        if let viewController = self.weatherViewControllerArray.first {
            updateView(viewController)
        }
    }
    
    func setupViewControllers(with data:[WeatherData]) {
        
        var viewContollers = [WeatherViewController]()
        for dataItem in data {
           let viewController = weatherViewController()
            viewController.model = dataItem
            viewController.apiClient = self.apiClient
            viewContollers.append(viewController)
        }
        self.weatherViewControllerArray = viewContollers
    }

    func weatherViewController() -> WeatherViewController {
        
        let viewContoller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Weather") as! WeatherViewController
        return viewContoller
        
    }
}



// MARK: UIPageViewControllerDataSource

extension WeatherDataPageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        guard let viewControllerIndex = weatherViewControllerArray?.index(of: viewController as! WeatherViewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return weatherViewControllerArray[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
       
        
        guard let viewControllerIndex = weatherViewControllerArray?.index(of: viewController as! WeatherViewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < weatherViewControllerArray.count else {
            return nil
        }
        return weatherViewControllerArray[nextIndex]
    }
    

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return weatherViewControllerArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func updateView(_ viewController:WeatherViewController) {
        
        self.pageChangedDelegate?.didChange(to: viewController.model)
        self.view.backgroundColor = viewController.model.weatherStatus?.color()
    }
}

extension WeatherDataPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
       let viewController = pageViewController.viewControllers!.first! as! WeatherViewController
       updateView(viewController)

    }

}
