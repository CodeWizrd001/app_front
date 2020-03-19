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
  final int len ;

  StuList({this.list,this.len}) ;


  int get length
  {
    print("Entered Get") ;  
    return len ;
  }

  factory StuList.fromJson(Map<String,dynamic> json)
  {
    //List<String> t ;
    var t = json['data'] ;
    int x = t.length ;
    List<Stu> z = [] ;
    print("List Length $x") ;
    for(int i=0;i<x;i+=1)
    {
      var tmp = t[i] ;
      var temp = Stu.fromJson(tmp) ;
      z.add(temp) ;
    }
    print(t) ;
    for(int i=0;i<x;i+=1)
    {
      var t = z[i] ;
      var p = t.name  ;
      var y = t.age ;
      print("$p : $y") ;
    }
    print("Clear 1") ;
    return StuList(list: z,len : x) ;
  }
  
}