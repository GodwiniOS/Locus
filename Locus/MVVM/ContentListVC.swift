//
//  ViewController.swift
//  Locus
//
//  Created by Godwin A on 05/09/22.
//

import UIKit


struct ImageModel{
    var index: Int
    var image: UIImage
}
class ContentListVC: UIViewController{

    // MARK: - Properties
    var contentListTV = UITableView()
    var vm = contentListViewModel()
    var tempIndex: Int?
    let pickerController = UIImagePickerController()
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }

    private func prepareView() {
        

        self.navigationController?.navigationBar.topItem?.title = "POST"
        

        let rightBarButton = UIBarButtonItem(title: "Json View", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = rightBarButton
        

//        vm.delegate = self
        
        // prepare ListTable
        view.addSubview(contentListTV)
        contentListTV.prepareLayout(.top)
        contentListTV.prepareLayout(.bottom)
        contentListTV.prepareLayout(.leading)
        contentListTV.prepareLayout(.trailing)
        contentListTV.registerCell()
        contentListTV.delegate = self
        contentListTV.dataSource = self
        contentListTV.separatorStyle = .none
        pickerController.delegate = self
        }
    

    

    
    @objc func addTapped(_ sender: AnyObject){
        let vc = JSONVC()
        vc.text = vm.jsongenerate()
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension ContentListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.listVM.count//vm.movieCount
    }
    
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        var cell: UITableViewCell?
        let item = vm.listVM[indexPath.row]
        switch item.type {
        case .photo:
            cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            if let c = cell as? ImageTableViewCell{
                c.delegate = self
                c.prepareTVC(image: vm.listVM[indexPath.row].image,
                             title: item.title,
                             index: indexPath.row)

            }

        case .singleOption:
//            cell = tableView.dequeueReusableCell(withIdentifier: "OptionTableViewCell", for: indexPath) as! OptionTableViewCell
//            if let c = cell as? OptionTableViewCell{
                let c = OptionTableViewCell()
                c.delegate = self
                c.prepareTVC(title: item.title, options: item.options!,
                             selectedIndex: vm.listVM[indexPath.row].selectedIndex,
                             row: indexPath.row)
//            }
            return c

        case .comment:
            cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
            if let c = cell as? CommentTableViewCell{
                c.delegate = self
                c.prepareTVC(title: item.title,
                             state: vm.listVM[indexPath.row].stateComment,
                             row: indexPath.row, cmt: vm.listVM[indexPath.row].cmttext)
                
            }
            
        default: cell = UITableViewCell()
        }
        
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let vc = ImageVC()
//        vc.image = vm.listVM[indexPath.row].image
//            navigationController?.pushViewController(vc, animated: true)
//    }
}

//MARK:- Imagepicker Delegate
extension ContentListVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as! UIImage
        
        picker.dismiss(animated: false)
        vm.listVM[tempIndex!].image = image
        
        DispatchQueue.main.async {
            self.contentListTV.reloadRows(at: [IndexPath(row: self.tempIndex!,
                                                         section: 0)],
                                          with: .none)
            self.tempIndex = nil

        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        tempIndex = nil
        pickerController.dismiss(animated: true)
    }
}

extension ContentListVC: TableViewCellDelegate{
    
    func imageClickedToOpen(image: UIImage) {
        let vc = ImageVC()
         vc.image = image
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func comment(text: String, row: Int) {
        vm.listVM[row].cmttext = text
    }
    
    func reload() {
        DispatchQueue.main.async {
            self.contentListTV.reloadData()
        }
    }
    
    
    func comment(state: Bool, row: Int) {
        
        vm.listVM[row].stateComment = state
        
        if !state {
            vm.listVM[row].cmttext = ""
        }
        DispatchQueue.main.async {
            self.contentListTV.reloadRows(at: [IndexPath(row: row,
                                                         section: 0)],
                                          with: .none)
        }
    }
    
    func optionClicked(option: Int,row:Int) {
        vm.listVM[row].selectedIndex = option
        
        DispatchQueue.main.async {
            self.contentListTV.reloadRows(at: [IndexPath(row: row,
                                                         section: 0)],
                                          with: .none)
        }
    }
    
    func removePic(index:Int) {
        tempIndex = nil
        vm.listVM[index].image = nil
        DispatchQueue.main.async {
            self.contentListTV.reloadRows(at: [IndexPath(row: index,
                                                         section: 0)],
                                          with: .none)
        }
    }
    
    
    func imageClick(index:Int) {
        tempIndex = index
        pickerController.sourceType = .camera
        present(pickerController, animated: true)
    }
}
