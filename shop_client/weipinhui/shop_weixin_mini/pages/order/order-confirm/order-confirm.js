//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
var http = require('../../../utils/httputils.js');

Page({
  data: {
    goods: "",
    addr: null,
    costSum: 0
  },
  methods: {
  },
  onLoad: function (option) {
    this.queryData(option.id)
    this.queryDefaultAddr()
  },
  queryData(goodsId) {
    let _this = this
    http.get('shop/goods/' + goodsId, '',
      function (resp) {
        _this.setData({
          goods: resp.data
        })

        _this.setData({
          costSum: "￥" + resp.data.price / 100
        })
      },
      function (err) { })
  },
  queryDefaultAddr() {
    let _this = this
    http.get('shop/addr_default', '',
      function (resp) {
        _this.setData({
          addr: resp.data
        })
      },
      function (err) { })
  },
  createOrder(e) {
    let _this = this
    var simpleCartItem = new Object();
    simpleCartItem.goodsId = this.data.goods.id;
    simpleCartItem.quantity = 1;
    var arr = [simpleCartItem];
    var params = {
      simpleCartItemList: arr,
      addressId: this.data.addr.id
    }
    http.post('shop/orders', params,
      function (resp) {
        wx.navigateBack()
        _this.gotoOrderDetail(resp.data.orderId)
      },
      function (err) { })

  },
  gotoOrderDetail(orderId) {
    wx.navigateTo({
      url: '/pages/order/order-detail/order-detail?id=' + orderId
    })
  },
  gotoSelectAddr(e) {
    if (this.data.addr != null) {
      wx.navigateTo({
        url: '/pages/addr/addr-select/addr-select?id=' + this.data.addr.id
      })
    } else {
      wx.navigateTo({
        url: '/pages/addr/addr-select/addr-select'
      })
    }
  },
})