import 'dart:convert';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_algostudio/components/home/home_model.dart';
import 'package:test_algostudio/utils/api.dart';

class HomeController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var loadData = false.obs;

  var listData = <HomeModel>[].obs;

  var page = 15.obs;

  void startLoad() {
    getData();
  }

  void getData() async {
    listData.clear();
    listData.refresh();
    loadData.value = true;
    loadData.refresh();
    var connect = Api.connectionApi("get", "", "get_memes");
    var getValue = await connect;
    var valueBody = jsonDecode(getValue.body);
    if (valueBody["success"] == true && valueBody["data"]["memes"].isNotEmpty) {
      List<HomeModel> tampungData = [];
      for (var element in valueBody["data"]["memes"]) {
        tampungData.add(HomeModel(
          id: element["id"],
          name: element["name"],
          url: element["url"],
          width: double.parse("${element['width']}"),
          height: double.parse("${element['height']}"),
        ));
      }
      listData.value = tampungData;
      listData.refresh();
      loadData.value = false;
      loadData.refresh();
    } else {
      loadData.value = false;
      loadData.refresh();
    }
  }
}
