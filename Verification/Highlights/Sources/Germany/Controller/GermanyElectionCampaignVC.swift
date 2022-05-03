//
//  GermanyElectionCampaignVC.swift
//  Verification
//
//  Created by Мехрафруз on 12.06.2021.
//
import UIKit
import TensorFlowLite
import Firebase

class GermanyElectionCampaignVC: UIViewController {
    
    //MARK: - Properties
    lazy private var mainView = GermanyElectionCampaignView(subscriber: self)

    //MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.mainView.showHeaderImage(navigationBar: self.navigationController?.navigationBar)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addObserver()
    }
    
    //MARK: - Methods
    func loadModelForecast(input: [Float]) {
        guard let modelPath = Bundle.main.path(
            forResource: "model_Germany",
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
            print(outputValue)
            // ...
        }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(hideHeaderImage),
                                               name: .hideHeaderImage,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showHeaderImage),
                                               name: .showHeaderImage,
                                               object: nil)
    }
    
    private func setupViews() {
        mainView.configureNavBar(navigationBar: navigationController?.navigationBar, navigationItem: navigationItem)
    }
    
    @objc
    private func hideHeaderImage(){
        self.mainView.hideHeaderImage(navigationBar: self.navigationController?.navigationBar)
    }
    
    @objc
    private func showHeaderImage(){
        self.mainView.showHeaderImage(navigationBar: self.navigationController?.navigationBar)
    }
}

//MARK: - MainView Delegate
extension GermanyElectionCampaignVC: GermanyElectionCampaignViewDelegate {
}

//MARK: - ScrollView Stuff
extension GermanyElectionCampaignVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.mainView.endEditing(true)
        saveTextFieldValues()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    public func saveTextFieldValues() {
        let textFields = [ self.mainView.firstTextField,  self.mainView.secondTextField,  self.mainView.thirdTextField,  self.mainView.fouthrTextField,  self.mainView.fifthTextField,  self.mainView.sixthTextField,  self.mainView.seventhTextField,  self.mainView.eighthTextField,  self.mainView.ninthTextField,  self.mainView.tenthTextField,  self.mainView.eleventhTextField,  self.mainView.twelfthTextField,  self.mainView.thirteenthTextField]
        
        mass.removeAll()
        for i in textFields{
           
            mass.append(Float(i.text ?? "0") ?? 0.0)
        }
        print(mass)
    }
    
}

