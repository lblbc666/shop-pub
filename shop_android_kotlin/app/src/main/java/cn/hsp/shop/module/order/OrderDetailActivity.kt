package cn.hsp.shop.module.order

import android.content.Context
import android.view.LayoutInflater
import android.widget.LinearLayout
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import cn.hsp.shop.R
import cn.hsp.shop.base.BaseVmActivity
import cn.hsp.shop.network.request.SimpleOrderInfo
import cn.hsp.shop.network.response.FullOrderInfo
import cn.hsp.shop.network.response.QueryOrderResp
import cn.hsp.shop.utils.Constants.EXTRA_KEY_ORDER_INFO
import cn.hsp.shop.utils.JsonUtil
import cn.hsp.shop.utils.formatTime
import cn.hsp.shop.utils.getMoneyByYuan
import cn.hsp.shop.utils.toast
import com.bumptech.glide.Glide
import kotlinx.android.synthetic.main.activity_goods.toolbar
import kotlinx.android.synthetic.main.activity_order_detail.*
import kotlinx.android.synthetic.main.order_detail_fee_layout.*
import kotlinx.android.synthetic.main.order_detail_order_info_layout.*

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：花生皮编程
 */
open class OrderDetailActivity : BaseVmActivity<OrderDetailViewModel>() {
    private var queryOrderResp: QueryOrderResp? = null
    override fun viewModelClass() = OrderDetailViewModel::class.java
    override fun layoutResId(): Int = R.layout.activity_order_detail

    override fun initView() {
        initToolbar()
    }

    override fun initData() {
        val orderInfoInJson = intent.getStringExtra(EXTRA_KEY_ORDER_INFO)
        queryOrderResp = JsonUtil.fromJson(orderInfoInJson!!)
        queryOrderResp?.let {
            orderIdTv.text = it.orderId
            val sum = calcSum(it.list)
            orderDetailSumTv.text = getString(R.string.price, sum)
            realPaidTv.text = getString(R.string.real_paid, sum)
            orderCreateTimeTv.text = formatTime(it.createTime)
            createOrderDetailItems(it.list, ordersDetailContainer)
        }
    }

    private fun createOrderDetailItems(list: List<FullOrderInfo>?, ordersContainer: LinearLayout) {
        ordersContainer.removeAllViews()
        list?.forEach {
            createOrderDetailItem(this, it, ordersContainer)
        }
    }

    private fun createOrderDetailItem(
        context: Context,
        orderInfo: FullOrderInfo,
        ordersContainer: LinearLayout
    ) {
        val view =
            LayoutInflater.from(context).inflate(R.layout.item_order_detail, ordersContainer, false)
        val imageUrl = orderInfo.squarePic
        Glide.with(context).load(imageUrl).into(view.findViewById(R.id.orderDetailGoodsIv))
        view.findViewById<TextView>(R.id.orderDetailGoodsNameTv).text = orderInfo.name
        view.findViewById<TextView>(R.id.orderDetailPrice).text =
            context.getString(R.string.price, getMoneyByYuan(orderInfo.price))
        view.findViewById<TextView>(R.id.orderDetailQuantity).text =
            context.getString(R.string.amount_with_prefix, orderInfo.quantity)
        ordersContainer.addView(view)
    }


    override fun initListeners() {
//        createOrderTv.setOnClickListener {
//            orderInfo?.let { createOrder(it) }
//        }
    }

    private fun createOrder(orderInfo: SimpleOrderInfo) {
//        mViewModel.createOrder(orderInfo, onSuccess = {
//            showPayDialog(it)
//        })
    }

    private fun showPayDialog(orderId: String) {
        val message = "现在支付么？"
        val alertDialog = AlertDialog.Builder(this).setMessage(message).setCancelable(false)
            .setPositiveButton(R.string.pay)
            { _, _ ->
                pay(orderId)
            }
            .setNegativeButton(R.string.cancel) { _, _ ->
                Toast.makeText(this, "用户点击了取消", Toast.LENGTH_SHORT).show()
            }
            .create()
        alertDialog.show()
    }

    private fun pay(orderId: String) {
        mViewModel.payForOrder(orderId, onSuccess = {
            toast("付款成功")
        })
    }

    private fun initToolbar() {
        toolbar.setNavigationOnClickListener { finish() }
    }

    private fun calcSum(data: List<FullOrderInfo>?): CharSequence {
        val sum = data?.sumOf { it.price * it.quantity } ?: 0L
        return getMoneyByYuan(sum)
    }
}
