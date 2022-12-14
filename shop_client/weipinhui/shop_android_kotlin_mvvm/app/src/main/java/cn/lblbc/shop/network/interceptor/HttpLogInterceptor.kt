package cn.lblbc.shop.network.interceptor

import android.util.Log
import okhttp3.Interceptor
import okhttp3.Response
import okio.Buffer
import java.nio.charset.Charset
import java.nio.charset.UnsupportedCharsetException

/**
 * 厦门大学计算机专业 | 前华为工程师
 * 专注《零基础学编程系列》  http://lblbc.cn/blog
 * 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
 * 公众号：蓝不蓝编程
 */
class HttpLogInterceptor : BaseInterceptor() {
    private val tag = HttpLogInterceptor::class.java.simpleName
    private val utf8 = Charset.forName("UTF-8")

    override fun interceptMe(chain: Interceptor.Chain): Response {
        val request = chain.request()
        val requestBody = request.body()
        var body: String? = null
        requestBody?.let {
            val buffer = Buffer()
            requestBody.writeTo(buffer)
            var charset = utf8
            val contentType = requestBody.contentType()
            contentType?.let {
                charset = contentType.charset(utf8)
            }
            body = buffer.readString(charset)
        }

        Log.d(
            tag,
            "发送请求: method：" + request.method()
                    + "\nurl：" + request.url()
                    + "\n请求头：" + request.headers()
                    + "\n请求参数: " + body
        )

        val response = chain.proceed(request)

        val responseBody = response.body()
        val rBody: String

        val source = responseBody!!.source()
        source.request(java.lang.Long.MAX_VALUE)
        val buffer = source.buffer()

        var charset = utf8
        val contentType = responseBody.contentType()
        contentType?.let {
            try {
                charset = contentType.charset(utf8)
            } catch (e: UnsupportedCharsetException) {
                Log.e(tag, e.message ?: "未知错误")
            }
        }
        rBody = buffer.clone().readString(charset)

        Log.d(
            tag,
            "收到响应: code:" + response.code()
                    + "\n请求url：" + response.request().url()
                    + "\n请求body：" + body
                    + "\nResponse: " + rBody
        )

        return response
    }
}
