//
//  ViewController.swift
//  stockCostApp
//
//  Created by water on 2021/8/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buyPriceTextField: UITextField!
    @IBOutlet weak var StockVolumeTextField: UITextField!
    @IBOutlet weak var StockCommissionTextField: UITextField!
    @IBOutlet weak var sellPriceTextField: UITextField!
    @IBOutlet weak var buyCostLabel: UILabel!
    @IBOutlet weak var stockCommissionStepper: UIStepper!
    @IBOutlet weak var stockVolumeStepper: UIStepper!
    @IBOutlet weak var sellTaxLabel: UILabel!
    @IBOutlet weak var sellCostLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var daytradeSwitch: UISwitch!
    @IBOutlet weak var stockView: UIView!
    
    
    let stockCost:Double = 0.1425  //手續費 買進賣出0.1425%
    var stockTax:Double = 0.003       // 交易稅 0.3%
    var dayTradeTax:Double = 0.0015     //當沖交易稅減半
    var buyPrice:Double = 0.0 //買進價
    var stockVolume:Int = 0   //買進股數
    var stockdiscount:Double = 10 //券商折扣,預設10為沒有折扣
    var sellPrice:Double = 0.0 //買出價
    var buyCost:Double = 0.0 //買進成本
    var sellCost:Double = 0.0   //賣出成本
    var sellTax:Double = 0.0 //證交稅
    var totalCost:Double = 0.0 //總交易成本
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buyPriceTextField.text = "100"
        StockVolumeTextField.text = "1000"
        StockCommissionTextField.text = "2.8"
        sellPriceTextField.text = "100"
        stockView.layer.cornerRadius = 15
        daytradeSwitch.isOn = false //當沖開關預設關閉
        // Do any additional setup after loading the view.
    }
    
    @IBAction func acountVolume(_ sender: Any) {
        StockVolumeTextField.text = String(format:"%.0f",stockVolumeStepper.value)
    }
    
    @IBAction func acountDiscount(_ sender: Any) {
        StockCommissionTextField.text = String(format:"%.1f",stockCommissionStepper.value)
    }
    

    @IBAction func cal(_ sender: Any) {
        buyPrice = Double(buyPriceTextField.text!) ?? 0
        stockVolume = Int(StockVolumeTextField.text!) ?? 0
        stockdiscount = Double(StockCommissionTextField.text!) ?? 0
        sellPrice = Double(sellPriceTextField.text!) ?? 0
        
        //計算買進手續費
        buyCost = (buyPrice * Double(stockVolume) * stockCost * stockdiscount)/1000
        buyCostLabel.text = String(format:"%.1f", buyCost) //顯示買進手續費
        
        //計算賣出手續費
        sellCost = (sellPrice * Double(stockVolume) * stockCost * stockdiscount) / 1000
        sellCostLabel.text = String(format: "%.1f", sellCost) //顯示賣出手續費
        
        //計算證交稅 判斷是否當沖交易
        if daytradeSwitch.isOn {
            sellTax = sellPrice * dayTradeTax * Double(stockVolume)
        } else {
            sellTax = sellPrice * stockTax * Double(stockVolume)
        }
        
        sellTaxLabel.text = String(format: "%.1f", sellTax) //顯示證交稅
        
        //買買交易總成本
        totalCost = buyCost + sellCost + sellTax
        totalCostLabel.text = String(format: "%.1f", totalCost)
        
        view.endEditing(true)  //收鍵盤
        
    }

    
    
}

