class Category_Name{
  String name;
  Category_Name({this.name});

  Category_Name.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'];


  Map<dynamic, dynamic> toJson() => {
    'name': name,
  };
}
Category_Name cat = Category_Name();