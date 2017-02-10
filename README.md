# DropdownPickerView
Simple to use and Lightweight Dropdown Picker Menu.
<img src="https://github.com/aatish-rajkarnikar/DropdownPickerView/blob/master/DropdownPickerView/DropdownPickerView/demo.gif"/>

# Installation
Download the DropdownPickerView.swift file and copy it to your project.

# Usage
1. Drag a UIView and make it subclass of DropdownPickerView.
2. Add constraints expect for Height.
3. Go to **Size Inspector** and change the **Intrinsic Size** from **Default** to **Placeholder**.
4. Make a outlet of PickerView.
5. Set Datasource for PickerView.
```Swift
    @IBOutlet var pickerView: DropdownPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = ["option 1","option 2","option 2","option 4","option 5"]
    }
```
6. Confirm to **DropdownPickerViewDelegate**.
```Swift
    func pickerView(pickerView: DropdownPickerView, didSelectAt index: NSInteger, withValue value: String) {
        //Called when user select an option from dropdown.
    }
    
    func pickerView(didOpen pickerView: DropdownPickerView) {
        //Called when user tries to open the dropdown picker. 
    }
    
    func pickerView(didClose pickerView: DropdownPickerView) {
        //Called when user tries to close the dropdwon picker.
    }
```

