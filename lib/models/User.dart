class currentUser{
  //int id;
  String name;
  String image;

  currentUser({required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return {
      'name' : this.name,
      'image' : this.image,
    };
  }
}