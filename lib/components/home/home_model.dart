import 'dart:convert';

class HomeModel {
  String? id;
  String? name;
  String? url;
  double? width;
  double? height;

  HomeModel({this.id, this.name, this.url, this.width, this.height});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "url": url,
      "width": width,
      "height": height
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
        id: map[" id"],
        name: map[" name"],
        url: map[" url"],
        width: map[" width"],
        height: map[" height"]);
  }

  String toJson() => json.encode(toMap());
}
