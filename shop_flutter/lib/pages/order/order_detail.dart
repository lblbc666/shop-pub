import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/constants.dart';
import 'package:shop_flutter/network/bean/query_order_detail_resp.dart';
import 'package:shop_flutter/network/http_manager.dart';
import 'package:shop_flutter/ui_kit.dart';

/// 厦门大学计算机专业 | 前华为工程师
/// 专注《零基础学编程系列》https://cxyxy.blog.csdn.net/article/details/121134634
/// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
/// 公众号：蓝不蓝编程

class OrderDetailPage extends StatefulWidget {
  String orderId;

  OrderDetailPage(this.orderId, {Key? key}) : super(key: key);

  @override
  createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetailPage> {
  QueryOrderDetailData? _queryOrderDetailData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单详情"),
        backgroundColor: LblColors.mainColor,
      ),
      body: Container(
          margin: const EdgeInsets.fromLTRB(5, 20, 10, 0),
          child: Column(
            children: [
              Expanded(
                  child: Column(children: [
                Container(
                  decoration: const BoxDecoration(
                    //设置背景色
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text("X商自营", style: TextStyle(fontSize: 18.0, color: Colors.black)),
                          Spacer(),
                          Text("状态")
                        ],
                      ),
                      Column(
                        children: buildOrderDetailList(),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                ),
              ])),
              defaultDivider(),
              buildBottomRow()
            ],
          )),
    );
  }

  List<Widget> buildOrderDetailList() {
    if (_queryOrderDetailData == null) {
      return [emptyContainer()];
    } else {
      return _queryOrderDetailData!.list.map((QueryOrderDetailDataItem queryOrderDetailDataItem) {
        return Column(
          children: [
            Row(
              children: [
                Image(
                  image: NetworkImage(queryOrderDetailDataItem.squarePic),
                  width: 100,
                  height: 100,
                ),
                myVerticalSpacer(10),
                Expanded(child: Text(queryOrderDetailDataItem.name, maxLines: 2, overflow: TextOverflow.ellipsis)),
                Column(
                  children: [
                    Text("￥" + (queryOrderDetailDataItem.price / 100).toString()),
                    Text("×" + queryOrderDetailDataItem.quantity.toString())
                  ],
                )
              ],
            ),
          ],
        );
      }).toList();
    }
  }

  Container buildBottomRow() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Row(
        children: [
          Spacer(),
          OutlinedButton(
            child: const Text('删除订单', style: TextStyle(color: Color(0xFF575E64))),
            onPressed: () {},
          ),
          myVerticalSpacer(10),
          OutlinedButton(
            child: const Text('申请售后', style: TextStyle(color: Color(0xFF575E64))),
            onPressed: () {},
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _queryData();
  }

  _queryData() async {
    String url = "shop/order/query/" + widget.orderId;
    HttpManager.getInstance().get(url).then((resp) {
      var result = QueryOrderDetailResp.fromJson(resp);
      setState(() {
        _queryOrderDetailData = result.data;
      });
    });
  }
}
