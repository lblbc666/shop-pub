// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:shop_flutter/network/bean/query_cart_resp_entity.dart';
import 'package:shop_flutter/network/bean/query_category_resp_entity.dart';
import 'package:shop_flutter/network/bean/query_order_detail_resp_entity.dart';
import 'package:shop_flutter/network/bean/query_order_list_resp_entity.dart';
import 'package:shop_flutter/network/bean/query_user_addr_list_resp_entity.dart';
import 'package:shop_flutter/network/bean/query_user_addr_resp_entity.dart';

JsonConvert jsonConvert = JsonConvert();

class JsonConvert {
  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }
      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type == "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type == "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return JsonConvert.fromJsonAsT<T>(value);
      }
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return null;
    }
  }

  //Go back to a single instance by type
  static M? _fromJsonSingle<M>(Map<String, dynamic> json) {
    final String type = M.toString();
    if (type == (QueryCartResp).toString()) {
      return QueryCartResp.fromJson(json) as M;
    }
    if (type == (CartItem).toString()) {
      return CartItem.fromJson(json) as M;
    }
    if (type == (QueryCategroyResp).toString()) {
      return QueryCategroyResp.fromJson(json) as M;
    }
    if (type == (QueryCategoryRespData).toString()) {
      return QueryCategoryRespData.fromJson(json) as M;
    }
    if (type == (QueryOrderDetailResp).toString()) {
      return QueryOrderDetailResp.fromJson(json) as M;
    }
    if (type == (QueryOrderDetailData).toString()) {
      return QueryOrderDetailData.fromJson(json) as M;
    }
    if (type == (QueryOrderDetailDataItem).toString()) {
      return QueryOrderDetailDataItem.fromJson(json) as M;
    }
    if (type == (QueryOrderListResp).toString()) {
      return QueryOrderListResp.fromJson(json) as M;
    }
    if (type == (QueryOrderListRespData).toString()) {
      return QueryOrderListRespData.fromJson(json) as M;
    }
    if (type == (QueryOrderListRespDataItem).toString()) {
      return QueryOrderListRespDataItem.fromJson(json) as M;
    }
    if (type == (QueryOrderListRespDataUserAddr).toString()) {
      return QueryOrderListRespDataUserAddr.fromJson(json) as M;
    }
    if (type == (QueryUserAddrListResp).toString()) {
      return QueryUserAddrListResp.fromJson(json) as M;
    }
    if (type == (UserAddr).toString()) {
      return UserAddr.fromJson(json) as M;
    }
    if (type == (QueryUserAddrResp).toString()) {
      return QueryUserAddrResp.fromJson(json) as M;
    }

    print("$type not found");

    return null;
  }

  //list is returned by type
  static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
    if (<QueryCartResp>[] is M) {
      return data.map<QueryCartResp>((Map<String, dynamic> e) => QueryCartResp.fromJson(e)).toList() as M;
    }
    if (<CartItem>[] is M) {
      return data.map<CartItem>((Map<String, dynamic> e) => CartItem.fromJson(e)).toList() as M;
    }
    if (<QueryCategroyResp>[] is M) {
      return data.map<QueryCategroyResp>((Map<String, dynamic> e) => QueryCategroyResp.fromJson(e)).toList() as M;
    }
    if (<QueryCategoryRespData>[] is M) {
      return data.map<QueryCategoryRespData>((Map<String, dynamic> e) => QueryCategoryRespData.fromJson(e)).toList()
          as M;
    }
    if (<QueryOrderDetailResp>[] is M) {
      return data.map<QueryOrderDetailResp>((Map<String, dynamic> e) => QueryOrderDetailResp.fromJson(e)).toList() as M;
    }
    if (<QueryOrderDetailData>[] is M) {
      return data.map<QueryOrderDetailData>((Map<String, dynamic> e) => QueryOrderDetailData.fromJson(e)).toList() as M;
    }
    if (<QueryOrderDetailDataItem>[] is M) {
      return data
          .map<QueryOrderDetailDataItem>((Map<String, dynamic> e) => QueryOrderDetailDataItem.fromJson(e))
          .toList() as M;
    }
    if (<QueryOrderListResp>[] is M) {
      return data.map<QueryOrderListResp>((Map<String, dynamic> e) => QueryOrderListResp.fromJson(e)).toList() as M;
    }
    if (<QueryOrderListRespData>[] is M) {
      return data.map<QueryOrderListRespData>((Map<String, dynamic> e) => QueryOrderListRespData.fromJson(e)).toList()
          as M;
    }
    if (<QueryOrderListRespDataItem>[] is M) {
      return data
          .map<QueryOrderListRespDataItem>((Map<String, dynamic> e) => QueryOrderListRespDataItem.fromJson(e))
          .toList() as M;
    }
    if (<QueryOrderListRespDataUserAddr>[] is M) {
      return data
          .map<QueryOrderListRespDataUserAddr>((Map<String, dynamic> e) => QueryOrderListRespDataUserAddr.fromJson(e))
          .toList() as M;
    }
    if (<QueryUserAddrListResp>[] is M) {
      return data.map<QueryUserAddrListResp>((Map<String, dynamic> e) => QueryUserAddrListResp.fromJson(e)).toList()
          as M;
    }
    if (<UserAddr>[] is M) {
      return data.map<UserAddr>((Map<String, dynamic> e) => UserAddr.fromJson(e)).toList() as M;
    }
    if (<QueryUserAddrResp>[] is M) {
      return data.map<QueryUserAddrResp>((Map<String, dynamic> e) => QueryUserAddrResp.fromJson(e)).toList() as M;
    }

    print("${M.toString()} not found");

    return null;
  }

  static M? fromJsonAsT<M>(dynamic json) {
    if (json == null) {
      return null;
    }
    if (json is List) {
      return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
    } else {
      return _fromJsonSingle<M>(json as Map<String, dynamic>);
    }
  }
}
