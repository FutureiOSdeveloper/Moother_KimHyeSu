//
//  TodayDetailTVC.swift
//  AppleWeather
//
//  Created by 김혜수 on 2021/07/29.
//

import UIKit

class TodayDetailTVC: UITableViewCell {

    public static let identifier = "TodayDetailTVC"
    
    let collectionTitleList : [String] = ["일출", "일몰", "비 올 확률", "습도", "바람", "체감", "강수량", "기압", "가시거리", "자외선 지수"]
    var contentsList : [String] = []
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionview.delegate = self
        collectionview.dataSource = self
        registerXib()
        collectionview.backgroundColor = .clear
    }
    
    func reloadCollection(){
        collectionview.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerXib(){
        let nib = UINib(nibName: TodayDetailCVC.identifier, bundle: nil)
        collectionview.register(nib, forCellWithReuseIdentifier: TodayDetailCVC.identifier)
    }
    
    func setData(contentslist : [String]){
        self.contentsList.append(contentsOf: contentslist)
    }
    
}

extension TodayDetailTVC: UICollectionViewDelegate {
    
}

extension TodayDetailTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: TodayDetailCVC.identifier, for: indexPath) as? TodayDetailCVC else {
            return UICollectionViewCell()
        }
        cell.setData(title: collectionTitleList[indexPath.row], contents: contentsList[indexPath.row])
        // setData 해주기
        return cell
    }
    
    
}

extension TodayDetailTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 40)/2 , height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
