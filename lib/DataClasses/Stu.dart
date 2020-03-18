class Stu {
  final int age;
  final String name;

  Stu({this.name, this.age});

  factory Stu.fromJson(Map<String, dynamic> json) {
    return Stu(
      name: json['Name'],
age: json['Age'],
      );
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({this.userId, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class StuList {

  final List<Stu> list ;

  StuList({this.list}) ;

  factory StuList.fromJson(Map<String,dynamic> json)
  {
    //List<String> t ;
    var t = json['data'] ;
    print(t) ;
    return StuList(list: t) ;
  }
  
}