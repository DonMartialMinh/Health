class currentUser{
  //int id;
  String name;
  String image;
  String phoneNumber;
  int height;
  DateTime dateOfBirth;
  double desireWeight;

  currentUser({
    required this.name,
    required this.image,
    required this.desireWeight,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.height});

  Map<String, dynamic> toMap() {
    return {
      'name' : this.name,
      'image' : this.image,
      'desireWeight' : this.desireWeight,
      'dateOfBirth' : this.dateOfBirth,
      'height' : this.height,
      'phoneNumber' : this.phoneNumber,
    };
  }
}