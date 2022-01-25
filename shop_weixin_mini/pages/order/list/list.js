//index.js
//获取应用实例
var http = require('../../../utils/httputils.js');

Page({
  data: {
    orderList: [],
    tabs: ['全部', '待付款', '待发货', '待收货', '待评价', '退还/售后'],
    current: 0,
  },
  onLoad: function () {
    this.queryOrder()
  },
  onShow: function () {
    this.queryOrder()
  },
  tabSelect: function (e) {
    var current = e.currentTarget.dataset.id
    this.setData({
      current: current
    })
    this.queryOrder()
  },
  queryOrder() {
    let _this = this
    http.get('shop/order/queryByStatus/'+this.data.current, '',
      function (resp) {
        _this.setData({
          orderList: resp.data
        })
      },
      function (err) { })
  },
  gotoOrderDetail(e) {
    let orderId = e.currentTarget.dataset['id'];
    debugger
    wx.navigateTo({
      url: '/pages/order/order-detail/order-detail?id=' + orderId
    })
  },

})