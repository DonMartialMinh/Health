class currentUser{
  //int id;
  String name;
  String image;
  double desireWeight;

  currentUser({required this.name, required this.image, required this.desireWeight});

  Map<String, dynamic> toMap() {
    return {
      'name' : this.name,
      'image' : this.image,
      'desireWeight' : this.desireWeight
    };
  }
}