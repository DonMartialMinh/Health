class Weight{
  double weight;
  DateTime dateTime;

  Weight({required this.weight, required this.dateTime});

  Map<String, dynamic> toMap(){
    return {
      'weight' : this.weight,
      'dateTime' : this.dateTime
    };
  }
}