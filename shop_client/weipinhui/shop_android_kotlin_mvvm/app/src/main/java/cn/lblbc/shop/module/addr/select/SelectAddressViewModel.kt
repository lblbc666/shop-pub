package cn.lblbc.shop.module.addr.select

import androidx.lifecycle.MutableLiveData
import cn.lblbc.shop.base.BaseViewModel
import cn.lblbc.shop.network.ShopRepo
import cn.lblbc.shop.network.Address

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class SelectAddressViewModel : BaseViewModel() {
    val addressList: MutableLiveData<List<Address>> = MutableLiveData()

    fun query() {
        launch({
            addressList.value = ShopRepo.queryAddress()?.data
        })
    }

}