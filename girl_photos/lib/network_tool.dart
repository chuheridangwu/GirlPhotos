import 'package:dio/dio.dart';

class NetWorkTool {

  static int timeMills = DateTime.now().millisecondsSinceEpoch;

  // 获取服务器的接口，如果返回不正确，首页等接口不会请求成功
  Future<String> getBaseIP() async {
    try {
      Response response =
          await Dio().get('http://119.29.29.29/d?dn=apiv2.prettybeauty.biz');
      return response.data;
    } catch (e) {
      print("获取基础网络错误: $e");
    }
  }

  // 热门
  Future getHomeList() async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio(BaseOptions(headers: {
        "Host": "apiv2.prettybeauty.biz",
        "User-Agent": "Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)"
      })).get(
          'http://103.85.22.147/album/all?app=Fantastic&it=$timeMills&pageIndex=1&pageSize=10&styleId=0&type=0&version=1.8');
      print(response.data);
      print(response.statusCode);
      return response.data;
    } catch (e) {
      print("获取首页网络错误$e");
    }
  }

  VoidCallback back;

  // 最新
  Future getLatestList() async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio(BaseOptions(headers: {
        "Host": "apiv2.prettybeauty.biz",
        "User-Agent": "Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)"
      })).get(
          'http://103.85.22.147/album/all?app=Fantastic&it=$timeMills&pageIndex=1&pageSize=10&styleId=0&type=1&version=1.8');
      print(response.data);
      print(response.statusCode);
      return response.data;
    } catch (e) {
      print("获取最新接口网络错误$e");
    }
  }

  // 排行
  Future getRankingList() async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio(BaseOptions(headers: {
        "Host": "apiv2.prettybeauty.biz",
        "User-Agent": "Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)"
      })).get(
          'http://103.85.22.147/girl/all?app=Fantastic&it=$timeMills&pageIndex=1&pageSize=10&version=1.8');
      print(response.data);
      print(response.statusCode);
      return response.data;
    } catch (e) {
      print("获取排行榜网络错误$e");
    }
  }
}
