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
    return "";
  }

  // 热门
  Future<List> getHomeList(int index) async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio(BaseOptions(headers: {
        "Host": "apiv2.prettybeauty.biz",
        "User-Agent": "Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)"
      })).get(
          'http://103.85.22.147/album/all?app=Fantastic&it=$timeMills&pageIndex=$index&pageSize=10&styleId=0&type=0&version=1.8');
      if (response.statusCode == 200) {
        return response.data["data"]["albums"].map((item) {
          return ListModel.fromJson(item);
        }).toList();
      }
    } catch (e) {
      print("获取首页网络错误$e");
    }
    return [];
  }

  VoidCallback back;

  // 最新
  Future<List> getLatestList(int index) async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio(BaseOptions(headers: {
        "Host": "apiv2.prettybeauty.biz",
        "User-Agent": "Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)"
      })).get(
          'http://103.85.22.147/album/all?app=Fantastic&it=$timeMills&pageIndex=$index&pageSize=10&styleId=1&type=1&version=1.8');
      if (response.statusCode == 200) {
        return response.data["data"]["albums"].map((item) {
          return ListModel.fromJson(item);
        }).toList();
      }
    } catch (e) {
      print("获取最新接口网络错误$e");
    }
    return [];
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

  // 用户详情
  Future<DetailModel> getUserInfo(String girlId, int index) async {
    Future<String> boseURL = getBaseIP();
    try {
      Response response = await Dio(BaseOptions(headers: {
        "Host": "apiv2.prettybeauty.biz",
        "User-Agent": "Beauty/1.10 (iPhone; iOS 12.1.2; Scale/2.00)"
      })).get(
          'http://103.85.22.147/girl/detail?app= Fantastic&girl_id=$girlId&it=$timeMills&pageIndex=$index&pageSize=10&version=1.8');
      if (response.statusCode == 200) {
        return DetailModel.fromJson(response.data["data"]["girl"]);
      }
    } catch (e) {
      print("获取排行榜网络错误$e");
    }
    return DetailModel([], "", "");
  }
}

// 数据模型
class DetailModel {
  String avatar;
  String name;
  List<ListModel> albums;
  DetailModel(this.albums, this.avatar, this.name);

  DetailModel.fromJson(Map json)
      : avatar = json["avatar"],
        name = json["name"],
        albums = json["albums"].map<ListModel>((item) {
          return ListModel.fromJson(item);
        }).toList();
}

class ListModel {
  String id;
  String girlId;
  String content;
  String host;
  Girl girl;
  List<Photo> photos;

  ListModel(
      this.id, this.content, this.girl, this.girlId, this.host, this.photos);

// 模型消息
  ListModel.fromJson(Map json)
      : id = json["id"],
        girlId = json["girlId"],
        content = json["content"],
        host = json["host"],
        girl = Girl.fromJson(json["girl"]),
        photos = json["photos"].map<Photo>((item) {
          return Photo.fromJson(item);
        }).toList();
}

// 女孩信息
class Girl {
  String id;
  String name;
  String avatar;
  String likeCount;

  Girl(this.avatar, this.id, this.likeCount, this.name);

  Girl.fromJson(Map json)
      : name = json["name"],
        id = json["id"],
        likeCount = json["likeCount"],
        avatar = json["avatar"];
}

// 图片
class Photo {
  String url;
  int width;
  int height;

  Photo(this.height, this.url, this.width);
  Photo.fromJson(Map json)
      : url = json["url"],
        width = json["width"],
        height = json["height"];
}
