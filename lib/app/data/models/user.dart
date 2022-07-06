class User {
  late final int id;
  final String name, imageUrl;
  bool connectionStatus;

  User({
    required this.name,
    required this.imageUrl,
    required this.id,
    this.connectionStatus = false,
  });

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["imageUrl"] = imageUrl;
    map["connectionStatus"] = connectionStatus;
    return map;
  }

  User fromJSON(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      connectionStatus: json["connectionStatus"],
    );
  }
}
