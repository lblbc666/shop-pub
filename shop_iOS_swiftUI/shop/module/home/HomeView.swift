// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @State var imageIndex: Int = 0
    
    var body: some View {
        NavigationView {
            VStack{
                LblBanner(goodsList: homeViewModel.dataListForBanner, height: 200, index: $imageIndex)

                List(homeViewModel.dataList) { goods in
                    NavigationLink(destination: GoodsView(goods: goods)) {
                        GoodsItemView1(goods: goods)
                    }
                }
            }
            .navigationBarTitle(Text("X商城"), displayMode: .inline)
        }
        .onAppear(perform: {
            homeViewModel.queryData()
        })
      
    }
}

struct GoodsItemView1: View {
    var goods: Goods
    var body: some View {
        HStack{
            WebImage(url: URL(string: goods.squarePic ?? ""))
                .placeholder{Color.gray}
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(goods.name).lineLimit(3)
        }
       
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
