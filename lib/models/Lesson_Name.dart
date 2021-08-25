class Lesson_Name{
  String name;
  Lesson_Name({this.name});

  Lesson_Name.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'];


  Map<dynamic, dynamic> toJson() => {
    'name': name,
  };
}
Lesson_Name les = Lesson_Name();