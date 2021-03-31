//
//  ViewController.swift
//  POCExpandableTableView
//
//  Created by Gustavo Gelabert Gabriel on 30/03/21.
//

import UIKit

enum CellType: String {
    case image
    case generic
    case bottom
}

struct CellData {
    var opened: Bool
    var type: CellType
    var title: String
    var sections: [String]
}

class ViewController: UIViewController {
    var tableViewData = [CellData]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let longText = "Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker.\n Lorem Ipsum é simplesmente uma simulação de texto da indústria tipográfica e de impressos, e vem sendo utilizado desde o século XVI, quando um impressor desconhecido pegou uma bandeja de tipos e os embaralhou para fazer um livro de modelos de tipos. Lorem Ipsum sobreviveu não só a cinco séculos, como também ao salto para a editoração eletrônica, permanecendo essencialmente inalterado. Se popularizou na década de 60, quando a Letraset lançou decalques contendo passagens de Lorem Ipsum, e mais recentemente quando passou a ser integrado a softwares de editoração eletrônica como Aldus PageMaker."

        tableViewData = [CellData(opened: false, type: .image, title: "", sections: []),
                         CellData(opened: false, type: .generic, title: "Title 1", sections: ["A", "B", "C"]),
                         CellData(opened: false, type: .generic, title: "Title 2", sections: ["D", "E", "F"]),
                         CellData(opened: false, type: .generic, title: "Title 3", sections: ["G", "H", "I", "G", "H", "I", "G", "H", "I", "G", "H", "I"]),
                         CellData(opened: false, type: .generic, title: "Title 4", sections: ["J", "K", "L", "J", "K", longText, "J", "K", "L"]),
                         CellData(opened: false, type: .generic, title: "Title 5", sections: ["M", "N", "O"]),
                         CellData(opened: false, type: .generic, title: "Title 6", sections: ["P", "Q", "R"]),
                         CellData(opened: false, type: .generic, title: "Title 7", sections: ["S", "T", "U"]),
                         CellData(opened: false, type: .generic, title: "Title 8", sections: ["W", "X", "Y"]),
                         CellData(opened: false, type: .generic, title: "Title 9", sections: ["Z"]),
                         CellData(opened: false, type: .bottom, title: "", sections: [])]

        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sections.count + 1
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        var resultCell = UITableViewCell()
        if tableViewData[indexPath.section].type == .image {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath) as? ImageViewTableViewCell {
                cell.immageViewTest.image = UIImage(named: "image2")
                resultCell = cell
            }
        } else if tableViewData[indexPath.section].type == .bottom {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "bottom", for: indexPath) as? BottomTableViewCell {
                cell.update.text = "test update"
                resultCell = cell
            }
        } else {
            if indexPath.row == 0 {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "title", for: indexPath) as? TitleTableViewCell {
                    cell.title.text = tableViewData[indexPath.section].title
                    resultCell = cell
                }
            } else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "body", for: indexPath) as? BodyTableViewCell {
                    cell.body.text = tableViewData[indexPath.section].sections[dataIndex]
                    resultCell = cell
                }
            }
        }
        return resultCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section > 0 {
            tableViewData[indexPath.section].opened = !tableViewData[indexPath.section].opened
            let sections = IndexSet.init(integer: indexPath.section)
            if tableViewData[indexPath.section].opened {
                tableView.reloadSections(sections, with: .none)
            } else {
                tableView.reloadSections(sections, with: .fade)
            }
        }
    }
}
