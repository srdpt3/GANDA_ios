//
//  CustomPicker.swift
//  GANDA
//
//  Created by Dustin yang on 1/28/22.
//

import SwiftUI



struct CustomPicker: UIViewRepresentable {
    @Binding var selected : String
    func makeCoordinator() -> CustomPicker.Coordinator {
        return CustomPicker.Coordinator(parent1: self)
    }

    
    func makeUIView(context: UIViewRepresentableContext<CustomPicker>) -> UIPickerView {
       let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        picker.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        picker.layer.cornerRadius  = picker.bounds.height / 2
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    
    func updateUIView(_ uiView : UIPickerView, context: UIViewRepresentableContext<CustomPicker>){
        
    }
    
    class Coordinator : NSObject, UIPickerViewDelegate, UIPickerViewDataSource{
        var parent : CustomPicker
        
        init(parent1 : CustomPicker){
            parent = parent1
        }
        
        func pickerView(_ pickerview : UIPickerView, numberOfRowsInComponent component : Int) -> Int {
            return itemData.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return itemData[row]
//        }
        
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            let view = UIView(frame: CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width / 3, height: 50))
            let label = UILabel(frame: CGRect(x: 0, y: 0, width:view.bounds.width, height: view.bounds.height))
            label.text = itemData[row]
            label.textColor = UIColor(APP_THEME_COLOR)
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 16, weight: .bold)
            view.backgroundColor = UIColor(Color("BG"))
            view.addSubview(label)

            view.clipsToBounds = true
            view.layer.borderWidth = 2.5
            view.layer.cornerRadius  = view.bounds.height / 2
            view.layer.borderColor =  UIColor(APP_THEME_COLOR).cgColor
            
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return UIScreen.main.bounds.width / 3
        }
        
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 50

        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selected = itemData[row]
        }
    }
    
    
}

//class Host: UIHostingController<ContentView>


var itemData = ["카테고리", "데일리룩", "데이팅룩" , "핫아이템", "악세사리", "신발", "기타"]
