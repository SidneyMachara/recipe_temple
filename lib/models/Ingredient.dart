class Ingredient {

  String name;
  int use;
  int  id;

  Ingredient( this.name, this.use);



  Ingredient.fromDb(Map map)
      :name = map["name"],
        use = map["use"],
        id = map["id"];

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['name'] = name;
    map['use'] = use;
    map['id'] = id;

    return map;
  }



}