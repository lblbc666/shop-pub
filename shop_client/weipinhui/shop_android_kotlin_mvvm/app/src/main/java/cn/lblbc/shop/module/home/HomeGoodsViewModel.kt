package cn.lblbc.shop.module.home

import androidx.lifecycle.MutableLiveData
import cn.lblbc.shop.base.BaseViewModel
import cn.lblbc.shop.network.ShopRepo
import cn.lblbc.shop.network.Goods

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class HomeGoodsViewModel : BaseViewModel() {
    val goodsList: MutableLiveData<List<Goods>> = MutableLiveData()

    fun queryGoods(categoryId: String) {
        launch({
            goodsList.value = ShopRepo.queryGoodsByCategory(categoryId)?.data
        })
    }
}