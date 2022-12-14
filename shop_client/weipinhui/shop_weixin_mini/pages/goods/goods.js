//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
var http = require('../../utils/httputils.js');

Page({
  data: {
    id: "",
    name: "",
    picUrl: "",
    descPicUrl: "",
    price: 0,
  },
  onLoad: function (option) {
    this.queryData(option.id)
  },
  queryData(goodsId) {
    let _this = this
    http.get('shop/goods/' + goodsId, '',
      function (resp) {
        _this.setData({
          id: resp.data.id,
          name: resp.data.name,
          picUrl: resp.data.squarePic,
          descPicUrl: resp.data.descPic.split(',')[0],
          price: '￥' + resp.data.price / 100
        })
      },
      function (err) { })
  },
  addToCart(e) {
    let goodsId = e.currentTarget.dataset['id'];
    var params = {
      goodsId: goodsId
    }
    http.post('shop/cart/', params,
      function (resp) {
        wx.showToast({
          title: '已加入购物车',
        })
      },
      function (err) { })
  },
  gotoConfirmOrder(e) {
    let goodsId = e.currentTarget.dataset['id'];
    wx.navigateTo({
      url: '/pages/order/order-confirm/order-confirm?id=' + goodsId
    })
  }

})