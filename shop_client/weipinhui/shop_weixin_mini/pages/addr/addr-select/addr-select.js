//厦门大学计算机专业 | 前华为工程师
//专注《零基础学编程系列》  http://lblbc.cn/blog
//包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
//公众号：蓝不蓝编程
var http = require('../../../utils/httputils.js');

Page({
  data: {
    dataList: [],
    selectedAddrId: ""
  },
  onLoad: function (option) {
    this.setData({
      selectedAddrId: option.id
    })
    this.queryData()
  },
  onShow: function () {
    this.queryData()
  },
  queryData() {
    let _this = this
    http.get('shop/addrs', '',
      function (resp) {
        _this.setData({
          dataList: resp.data
        })
      },
      function (err) { })
  },
  gotoAddAddr() {
    wx.navigateTo({
      url: '/pages/addr/addr-add/addr-add'
    })
  },
  gotoEditAddr(e) {
    let addressId = e.currentTarget.dataset['id'];
    wx.navigateTo({
      url: '/pages/addr/addr-edit/addr-edit?id=' + addressId
    })
  },
  deleteAddr(e) {
    let addressId = e.currentTarget.dataset['id'];
    let _this = this
    http.del('shop/addrs/' + addressId, '',
      function (resp) {
        _this.queryData()
      },
      function (err) { })
  },
  selectAddr(e) {
    let address = e.currentTarget.dataset['addr'];
    var pages = getCurrentPages();
    var prevPage = pages[pages.length - 2];  //上一个页面

    //直接调用上一个页面的setData()方法，把数据存到上一个页面中去
    prevPage.setData({
      addr: address
    })
    wx.navigateBack();
  }
})