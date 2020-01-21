

class Data{
  String name;
  List<String> films;
  Data({this.name,this.films});

  factory Data.fromJson(Map<String,dynamic> parsedJson){
    var listOfStrings = parsedJson['films'];
    List<String> stringList = new List<String>.from(listOfStrings);
    return Data(
      name: parsedJson['name'],
      films: stringList
    );
  }
}