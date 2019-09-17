import 'package:dio/dio.dart';

class NetWorkTool {
  Future<String> getBaseIP() async {
    try {
      Response response =
          await Dio().get('http://119.29.29.29/d?dn=apiv2.prettybeauty.biz');
      return response.data;
    } catch (e) {
      print("获取基础网络错误: $e");
    }
  }

  Future getHomeList() async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio().get(
          'http://103.85.22.147/album/all?app=Fantastic&it=1545917841&pageIndex=1&pageSize=10&styleId=0&type=0&version=1.8');
      // print(response.data);
      return response.data;
    } catch (e) {
      print("获取首页网络错误$e");
    }
  }
}
