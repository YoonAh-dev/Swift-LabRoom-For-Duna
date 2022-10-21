//
//  ViewController.swift
//  ControlSentenceMovingWithTouch
//
//  Created by SHIN YOON AH on 2022/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    private let sentenceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .gray
        return label
    }()
    private let content: String = """
    ‘타다’는 승합차를 유료로 타려는 이용자와 운전자를 연결해주는 차량공유 앱 서비스입니다. 승합차는 일반 택시보다 크고 마을버스보다 작은 차종을 말합니다. 대개 11~15인승입니다. 2018년 10월 ‘타다’라는 글자를 새긴 차가 처음 시장에 등장했습니다. 미국에서 차량공유 서비스인 ‘우버’가 주목받은 터여서 타다는 한국식 우버로 불리기도 했습니다.

    문제가 발생했습니다. 택시업계가 반발한 겁니다. “택시 면허가 없는 사람들이 택시 영업을 한다”고 주장했고 수사당국인 검찰이 1년 뒤인 2019년 10월 타다 운영업체 VCNC의 박재욱 대표와 모기업 쏘카의 이재웅 대표를 재판에 넘겼습니다. 1심과 2심 법원은 모두 ‘타다 무죄’를 선고했습니다. ‘모바일 앱과 승합차를 잇는 혁신 서비스’인지, ‘무면허 택시 영업행위’인지를 놓고 양측이 3년간 치열하게 싸웠습니다.

    누가 재판에 이겼느냐는 우리의 관심사가 아닙니다. 타다 재판의 이면에 웅크리고 있는 생각들에 주목해야 합니다. 혁신과 기득권의 대립, 새로운 것과 기존에 있던 것 사이의 충돌, 현재와 미래, 진화와 도태 같은 이슈들이죠.

    논술 측면에서 공부 할 내용이 참 많은 ‘타다’입니다. 법정 공방을 벌이는 사이 타다의 운명은 어떻게 됐을까요?
    """
    private var contents: [String] = []
    private var index: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        sentenceLabel.text = content
        
        view.addSubview(sentenceLabel)
        sentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sentenceLabel.topAnchor.constraint(equalTo: view.topAnchor),
            sentenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sentenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sentenceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        contents = content.components(separatedBy: [".", "?"]).map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        sentenceLabel.applyColor(to: "\(contents[index]).", with: .white)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        index += 1
        sentenceLabel.applyColor(to: "\(contents[index]).", with: .white)
    }
}
