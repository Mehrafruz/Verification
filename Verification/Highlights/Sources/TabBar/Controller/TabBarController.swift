//
//  TabBarController.swift
//  Verification
//
//  Created by Мехрафруз on 07.04.2021.
//

import UIKit
import TensorFlowLite
import Firebase


final class TabBarController: UITabBarController {
    
    //MARK: - Properties
    private let allHighlightsCoordinator = USAElectionCampaignCoordinator(navigationController: UINavigationController())
    private let favoriteHighlightsCoordinator = GermanyElectionCampaignCoordinator(navigationController: UINavigationController())
    private let assemblyBuilder = USAElectionCampaignAssemblyBuilder()

    lazy private var mainView = TabBarView(subscriber: self)
    private let model = TabBarModel()
    private var tabBarItemIndex = 0
    
    //MARK: - Life cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard model.isFirstStart == true else { return }
        mainView.setLayers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        setupTabBar()
    }
    
    func loadModelForecast(input: [Float]) {
        var resourse = "model_USA"
        if tabBarItemIndex == 1 {
            resourse = "model_Germany"
        }
        guard let modelPath = Bundle.main.path(
          forResource: resourse,
          ofType: "tflite",
          inDirectory: ""
        ) else {
            print("error")
            return }
        let localModel = CustomLocalModel(modelPath: modelPath)
        print(localModel)
        let interpreter = ModelInterpreter.modelInterpreter(localModel: localModel)
        let inputs = ModelInputs()
        
        let ioOptions = ModelInputOutputOptions()
        do {
            try ioOptions.setInputFormat(index: 0, type: .float32, dimensions: [1, 13])
            try ioOptions.setOutputFormat(index: 0, type: .float32, dimensions: [1, 1])
        } catch let error as NSError {
            print("Failed to set input or output format with error: \(error.localizedDescription)")
        }
        
        var inputData = Data()
        do{
            for var i in input{
                var data = Data(buffer: UnsafeBufferPointer(start: &i, count: 1))
                inputData.append(data)
            }
            
            try inputs.addInput(inputData)} catch let error {
                print("Failed to add input: \(error)")
            }
        
        interpreter.run(inputs: inputs, options: ioOptions) { outputs, error in
            guard error == nil, let outputs = outputs else { return }
            // Process outputs
            let outputValue = try? outputs.output(index: 0) as? [[NSNumber]]
            let outputFloat = outputValue?[0]
            let alert = EditExitAlertVC()
            let text: String = String(format: "%f", outputFloat?[0].doubleValue as! CVarArg)
            alert.reloadData(text: text)
            self.present(alert, animated: true, completion: nil)
            print(outputFloat?[0])
        }
    }
    
    //MARK: - Methods
    private func setupTabBar() {
        self.tabBar.isHidden = true
        mainView.setConstraints(view: view, tabBarHeight: self.tabBar.frame.size.height)
        mainView.setNeededItem()
        mainView.checkTabBarSelected { [weak self] index in
            guard let self = self else { return }
            print(index)
            self.tabBarItemIndex = index
            self.selectedIndex = index
        }
        
    }
    
    private func setControllers() {
        self.viewControllers = [allHighlightsCoordinator.navigationController,
                           favoriteHighlightsCoordinator.navigationController]
       
    }
    
    public func animateHideTabBar() {
        self.mainView.animateHideCollectionView(view: self.view)
    }
    
    public func animateShowTabBar() {
        self.mainView.animateShowCollectionView(view: self.view)
    }
    
    
}

//MARK: - MainView Delegate
extension TabBarController: TabBarViewDelegate  {

    func addNewButtonAction() {
        loadModelForecast(input: mass)
        print("Add")
    }
}


