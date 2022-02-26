class GymModel {
  List<dynamic>? images;
  String? faciltrs;
  double? price;
  String? imageURL;
  String? name;
  String? description;
  String? location;
  bool? isFavorite;

  GymModel(
      {this.images,
      this.faciltrs,
      this.price,
      this.imageURL,
      this.name,
      this.description,
      this.location,
      this.isFavorite});

  GymModel.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    faciltrs = json['faciltrs'];
    price = double.parse(json['price'].toString());
    imageURL = json['imageURL'];
    name = json['name'];
    description = json['description'];
    location = json['Location'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['faciltrs'] = this.faciltrs;
    data['price'] = this.price;
    data['imageURL'] = this.imageURL;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}
