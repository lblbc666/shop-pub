import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_flutter/lblbc_constants.dart';
import 'package:shop_flutter/network/bean/query_user_addr_resp_entity.dart';
import 'package:shop_flutter/network/http_manager.dart';

/// 厦门大学计算机专业 | 前华为工程师
/// 专注《零基础学编程系列》  http://lblbc.cn/blog
/// 包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
/// 公众号：蓝不蓝编程

class EditAddrPage extends StatefulWidget {
  final String addressId;

  const EditAddrPage({Key? key, required this.addressId}) : super(key: key);

  @override
  createState() => _EditAddrState();
}

class _EditAddrState extends State<EditAddrPage> {
  QueryAddressRespData? addressData;
  var _defaultAddress = true;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var regionController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("修改收货地址"),
        backgroundColor: LblColors.mainColor,
        actions: [
          IconButton(
              onPressed: () {
                modifyAddr();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "请输入收货人真实姓名", labelText: "收货人"),
              controller: nameController,
            ),
            TextField(
                decoration: const InputDecoration(hintText: "请输入收货人手机号", labelText: "手机号"),
                controller: phoneController,
                keyboardType: TextInputType.number),
            TextField(
              decoration: const InputDecoration(hintText: "请输入所在地区", labelText: "所在地区"),
              controller: regionController,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "请输入详细地址",
                labelText: "详细地址",
              ),
              controller: addressController,
            ),
            Row(
              children: [Text("设为默认地址"), Spacer(), _newSwitch()],
            )
          ],
        )),
      ),
    );
  }

  _newSwitch() {
    return Switch(
      value: _defaultAddress,
      activeColor: Colors.white,
      activeTrackColor: Colors.green,
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Colors.grey,
      onChanged: (value) {
        setState(() {
          _defaultAddress = value;
        });
      },
    );
  }

  Container buildBottomRow() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      child: SizedBox(
        child: ElevatedButton(
          child: const Text('确定'),
          onPressed: () {
            modifyAddr();
          },
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFEF3965))),
        ),
      ),
    );
  }

  _queryData() async {
    String url = "shop/addrs/" + widget.addressId;
    HttpManager.getInstance().get(url).then((resp) {
      var result = QueryAddressRespEntity.fromJson(resp);
      var addrData = result.data;
      setState(() {
        addressData = addrData;
        _defaultAddress = addrData.defaultAddress;
      });
      nameController.text = addrData.name;
      phoneController.text = addrData.phone;
      regionController.text = addrData.region;
      addressController.text = addrData.address;
    });
  }

  void modifyAddr() {
    String url = "shop/addrs";

    if (addressData != null) {
      addressData!.name = nameController.value.text;
      addressData!.phone = phoneController.value.text;
      addressData!.region = regionController.value.text;
      addressData!.address = addressController.value.text;
      addressData!.defaultAddress = _defaultAddress;
      HttpManager.getInstance().put(url, data: addressData!.toJson()).then((resp) {
        Navigator.pop(context);
      });
    }
  }
}
