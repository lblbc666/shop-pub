package cn.lblbc.shop.module.cart

import androidx.lifecycle.MutableLiveData
import cn.lblbc.shop.base.BaseViewModel
import cn.lblbc.shop.network.ShopRepo
import cn.lblbc.shop.network.CartItem

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class CartViewModel : BaseViewModel() {
    val dataList: MutableLiveData<List<CartItem>> = MutableLiveData()
    val selectionItemList = mutableListOf<CartItem>()
    val selectionChangeCount: MutableLiveData<Int> = MutableLiveData()

    fun queryCart() {
        launch({
            dataList.value = ShopRepo.queryCart()?.data
            clearSelectionItems()
        })
    }

    private fun clearSelectionItems() {
        selectionItemList.clear()
        notifySelectionChanged()
    }

    fun modifyCart(cartItem: CartItem, isChecked: Boolean) {
        if (isChecked) {
            selectItem(cartItem)
        }
        launch({
            ShopRepo.modifyCart(cartItem.id, cartItem.quantity)
            if (cartItem.quantity <= 0) {
                queryCart()
            }
        })
    }

    fun selectItem(cartItem: CartItem) {
        val selectionItem = selectionItemList.firstOrNull { it.id == cartItem.id }
        if (selectionItem != null) {
            if (cartItem.quantity <= 0) {
                selectionItemList.remove(selectionItem)
            } else {
                selectionItem.quantity = cartItem.quantity
            }
        } else {
            selectionItemList.add(cartItem)
        }
        notifySelectionChanged()
    }

    fun disSelectItem(goodsId: String) {
        selectionItemList.removeIf { it.id == goodsId }
        notifySelectionChanged()
    }

    private fun notifySelectionChanged() {
        selectionChangeCount.value = selectionChangeCount.value?.inc()
    }
}