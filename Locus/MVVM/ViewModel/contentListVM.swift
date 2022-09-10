//
//  LocusListVC.swift
//  Locusz
//
//  Created by Godwin  on 14/01/21.
//

import Foundation
import UIKit

protocol ContentVMDelegate: AnyObject {
//    func reloadData(isFirstPage: Bool)
//    func showError(error: String)
}




class contentListViewModel {
    
    
    struct ListViewModel {
        
        var id: String?
        var title: String?
        var type: ItemType = .error
        var options: [String]?
        var stateComment: Bool?
        var image: UIImage?
        var selectedIndex: Int? {
            didSet{
                
            }
        }
        var cmttext = "" 

        enum ItemType: String{
            case photo = "PHOTO"
            case comment = "COMMENT"
            case singleOption = "SINGLE_CHOICE"
            case error = ""
        }
        
        enum RadioButtonModel: String{
            case buttonA
            case buttonB
            case buttonC
        }
        
        
        init(item: Dataset) {

            
            self.id = item.id
            self.title = item.title
            
            if let type = item.type{
                if type == ItemType.comment.rawValue{
                    self.type = .comment
                    stateComment = false
                } else if type == ItemType.photo.rawValue{
                    self.type = .photo
                } else if type == ItemType.singleOption.rawValue{
                    self.type = .singleOption
                    options = item.dataMap?.options
                }
            }
        }
    }
    
    // MARK: - Properties
    weak var delegate : ContentVMDelegate?
    var data: ResponseBase?
    var listVM: [ListViewModel] = []
        
    
    
    // MARK: - Methods
    init() {
//        do {
//            data = try JSONDecoder().decode(ResponseBase.self,
//                                             from: Data(dataSet.utf8))
//        } catch {
//            print(error.localizedDescription)
//        }
        
        do {
            if let bundlePath = Bundle.main.path(forResource: "Dataset",ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                data = try JSONDecoder().decode(ResponseBase.self,
                                                from: jsonData)
                
            }
        } catch {
            print(error.localizedDescription)
        }
        
        guard data != nil else { return }
        prepareViewModel()
    }
    
    
    func prepareViewModel(){
        
        guard let list = data?.dataset else { return }
        for item in list{
            listVM.append(ListViewModel(item: item))
        }
    }
    
    func jsongenerate() -> String{
        var value = ""
        for i in listVM {
            var last = ""

            switch i.type{
            case .photo:
                last = i.image == nil ? "Image Not Available" : "Image Available"
            case .comment:
                last = i.cmttext.isEmpty ? "**EMPTY** " : i.cmttext
            case .singleOption:
                if let index = i.selectedIndex,let option = i.options,index < option.count{
                    last = "Selected Option [ " + option[index] + " ]"
                } else {
                    last = "**No option Selected**"
                }
            case .error:
                print("")
            }
            value = value + " \n  \n ID: " + i.id! + " -> " + "Input: " + last
        }
        
        return value
    }
    
}

var dataSet = """
{
    "dataset": [
  {
    "type": "PHOTO",
    "id": "pic1",
    "title": "Photo 1",
    "dataMap": {
      "options": []
    }
  },
  {
    "type": "SINGLE_CHOICE",
    "id": "choice1",
    "title": "Photo 1 choice",
    "dataMap": {
      "options": [
        "Good",
        "OK",
        "Bad"
      ]
    }
  },
  {
    "type": "COMMENT",
    "id": "comment1",
    "title": "Photo 1 comments",
    "dataMap": {
      "options": []
    }
  },
  {
    "type": "PHOTO",
    "id": "pic2",
    "title": "Photo 2",
    "dataMap": {
      "options": []
    }
  },
  {
    "type": "SINGLE_CHOICE",
    "id": "choice2",
    "title": "Photo 2 choice",
    "dataMap": {
      "options": [
        "Good",
        "OK",
        "Bad"
      ]
    }
  },
  {
    "type": "COMMENT",
    "id": "comment2",
    "title": "Photo 2 comments",
    "dataMap": {
      "options": []
    }
  },
  {
    "type": "COMMENT",
    "id": "comment3",
    "title": "Photo 3 comments",
    "dataMap": {
      "options": []
    }
  },
  {
    "type": "PHOTO",
    "id": "pic3",
    "title": "Photo 3",
    "dataMap": {
      "options": []
    }
  },
  {
    "type": "SINGLE_CHOICE",
    "id": "choice2",
    "title": "Photo 3 choice",
    "dataMap": {
      "options": [
        "Nice",
        "Not Nice"
      ]
    }
  },
  {
    "type": "SINGLE_CHOICE",
    "id": "choice4",
    "title": "Photo 4 type",
    "dataMap": {
      "options": [
        "Document",
        "Face"
      ]
    }
  },
  {
    "type": "PHOTO",
    "id": "pic4",
    "title": "Photo 4",
    "dataMap": {
      "options": []
    }
  }
]
}
"""


