// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct OrderListView: View {
    @StateObject private var viewModel = OrderViewModel()
    @State var selectedIndex = 0
    var tabs: [LblTab] = [LblTab(id: 0,name: "全部"),LblTab(id: 1,name: "待付款"),LblTab(id: 2,name: "待发货"),LblTab(id: 3,name: "待收货"),LblTab(id: 4,name: "待评价"),LblTab(id: 5,name: "退换/售后")]
    
    var body: some View {
        VStack{
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<tabs.count) { i in
                        TabItemView(i)
                    }
                }
            }.padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
            OrderPageView(viewModel: viewModel, selectedIndex: $selectedIndex, tabs: tabs)
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 1, trailing: 0))
        }
    }
    
    fileprivate func TabItemView(_ i: Int) -> some View {
        return VStack{
            Text(tabs[i].name)
                .foregroundColor(selectedIndex == i ? Color.main_color : .gray)
                .padding(EdgeInsets.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .onTapGesture(perform: {
                    selectedIndex = i
                })
            Divider().frame(height: 2).background(selectedIndex == i ? Color.main_color : .white)
        }
    }
}

struct LblTab{
    var id: Int = 0
    var name: String = ""
    
    init(id:Int, name:String)
    {
        self.id = id
        self.name = name
    }
}

struct OrderPageView: View {
    @StateObject var viewModel: OrderViewModel
    @Binding var selectedIndex: Int
    var tabs: [LblTab]
    
    var body: some View {
        List {
            ForEach(viewModel.dataList.indices , id: \.self){ i in
                Text(viewModel.dataList[i].orderId)
            }
            
//            ForEach(viewModel.dataList , id: \.self){ orderInfo in
//                Text(orderInfo.orderId)
//                //                NavigationLink(destination: GoodsView(goods:goods)) {
//                //                    GoodsItemView(goods: goods)
//                //                }
//            }
        }.onChange(of: selectedIndex) {
            viewModel.queryOrderByStatusResp(orderStatus: tabs[$0].id)
        }.onAppear(perform: {
            viewModel.queryOrderByStatusResp(orderStatus: tabs[selectedIndex].id)
        })
    }
}


struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
