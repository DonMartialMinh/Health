class Tip{
  String title;
  String content;
  String image;

  Tip({required this.title, required this.content, required this.image});
  Map<String, dynamic> toMap(){
    return {
      'title' : title,
      'content' : content,
      'image' : image,
    };
  }
}