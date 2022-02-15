// 厦门大学计算机专业 | 前华为工程师
// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
// 公众号：蓝不蓝编程

import SwiftUI
import SDWebImageSwiftUI

struct OrderFromCartView: View {
    var goodsSum = 30
    var cartItems: [CartItem]
    //    @State var userAddr: UserAddr? = nil
    @StateObject private var viewModel = OrderFromCartViewModel()
    var body: some View {
        VStack{
            if let userAddr = viewModel.userAddr {
                HStack{
                    Image(systemName: "location.circle.fill")
                    VStack{
                        Text(userAddr.name)
                        Text(userAddr.address)
                    }
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(hex: 0x595D63))
                }.padding().background(.white).padding()
            }else{
                Text("+ 添加收货地址").padding().background(.white).padding()
            }
            
            WebImage(url: URL(string: cartItems[0].squarePic ?? ""))
                .placeholder{Color.gray}
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            
            Spacer()
            Divider()
            buildBottomView()
        }.background(Color(hex: 0xF4F4F4))
            .onAppear(perform: {
                viewModel.queryData()
            })
        
    }
    
    
    func buildBottomView() -> some View{
        return HStack{
            Spacer()
            Text("实付款")
            Text("￥\(goodsSum)").foregroundColor(Color.main_color)
            Spacer()
            //            NavigationLink(destination: OrderFromCartView()){
            //                Text("提交订单").font(.headline).frame(minWidth: 150)
            //                    .padding(EdgeInsets.init(top: 5, leading: 0, bottom: 5, trailing: 0))
            //                    .foregroundColor(.white)
            //                    .background(Color.main_color)
            //                    .clipShape(RoundedRectangle(cornerRadius: 5))
            //            }
            
            Spacer()
        } .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 5, trailing: 0))
    }
}

//struct OrderFromCartView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderFromCartView()
//    }
//}
