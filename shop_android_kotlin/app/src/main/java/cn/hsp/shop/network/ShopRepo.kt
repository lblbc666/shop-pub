/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：花生皮编程
 */
package cn.hsp.shop.network

import cn.hsp.shop.base.BaseRepository
import cn.hsp.shop.network.request.CreateOrderReq
import cn.hsp.shop.network.request.LoginReq
import cn.hsp.shop.network.request.QueryOrderReq
import cn.hsp.shop.network.request.RegisterReq

class ShopRepo : BaseRepository() {
    suspend fun queryGoods() = apiService.queryGoods()
    suspend fun queryGoods(goodsId: String) = apiService.queryGoods(goodsId)
    suspend fun queryCart() = apiService.queryCart()
    suspend fun addToCart(goodsId: String) = apiService.addToCart(goodsId)
    suspend fun modifyCart(goodsId: String, quantity: Int) =
        apiService.modifyCart(goodsId, quantity)

    suspend fun createOrder(req: CreateOrderReq) = apiService.createOrder(req)
    suspend fun payForOrder(orderId: String) = apiService.payForOrder(orderId)
    suspend fun queryOrder(req: QueryOrderReq) = apiService.queryOrder(req)
    suspend fun login(userName: String, password: String) =
        apiService.login(LoginReq(userName, password))

    suspend fun register(userName: String, password: String) =
        apiService.register(RegisterReq(userName, password))
}