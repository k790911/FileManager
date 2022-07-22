//
//  ViewController.swift
//  FileManagerTest01
//
//  Created by 김재훈 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fileManager = FileManager.default
        
        // for: 폴더를 정해주는 요소, in: 제한을 걸어주는 요소, 그 이상은 못가게 하는,,
        let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        //print(documentPath)
        
        let directoryPath: URL = documentPath.appendingPathComponent("newFolder")
        
        // 폴더 생성
        do {
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch let e {
            print(e.localizedDescription)
        }
        
        let textPath: URL = directoryPath.appendingPathComponent("hi.txt")
        
        // "hi.txt" 경로에 텍스트 쓰기
        if let data: Data = "안녕하세요".data(using: String.Encoding.utf8) {
            do {
                try data.write(to: textPath)
            } catch let e {
                print(e.localizedDescription)
            }
        }
        
        // 파일 불러와서 읽기
        do {
            // URL 불러와서 Data타입으로 초기화
            let dataFromPath: Data = try Data(contentsOf: textPath)
            
            let text: String = String(data: dataFromPath, encoding: .utf8) ?? "No Documents"
            
            print(text)
        } catch let e {
            print(e.localizedDescription)
        }
        
        // 파일을 삭제한다
        do {
            try fileManager.removeItem(at: textPath)
        } catch let e {
            print(e.localizedDescription)
        }
    }
}

