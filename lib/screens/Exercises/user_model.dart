class UserModel {
  final int id;
  final String name;

  UserModel({required this.id, required this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    //  if(json["business_name"] == null){

    //   }
    return UserModel(
      id: json["id"],
      name: json["name"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  // bool userFilterByCreationDate(String filter) {
  //   return this.createdAt?.toString().contains(filter) ?? false;
  // }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}
