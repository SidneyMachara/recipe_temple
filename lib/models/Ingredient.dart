class Ingredient {

  String name;
  int use;
  String avatar;
  int  id;

  Ingredient( this.name, this.use, this.avatar);

  Ingredient.fromDb(Map map)
      :name = map["name"],
        avatar = map["avatar"],
        use = map["use"],
        id = map["id"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['use'] = use;
    map['avatar'] = avatar;
    map['id'] = id;

    return map;
  }

}