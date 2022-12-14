package cn.lblbc.shop.module.login

import cn.lblbc.lib.utils.SpUtil
import cn.lblbc.shop.utils.SP_KEY_TOKEN

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
object LoginManager {
    fun isLoggedIn() = !SpUtil.get(SP_KEY_TOKEN, "").isNullOrEmpty()
    fun quitLogin() = SpUtil.remove(SP_KEY_TOKEN)
}