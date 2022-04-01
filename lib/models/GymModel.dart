class GymModel {
  List<dynamic>? images;
  List<dynamic>? faciltrs;
  double? priceOndDay;
  double? priceOndMonth;
  double? priceThreeMonts;
  double? priceSixMonths;
  double? priceOneYear;
  String? imageURL;
  String? gymId;
  String? ownerId;
  String? name;
  String? description;
  String? location;
  bool? isWaiting;
  bool? isComplete;

  GymModel(
      this.images,
      this.faciltrs,
      this.priceOndDay,
      this.priceOndMonth,
      this.priceOneYear,
      this.priceSixMonths,
      this.priceThreeMonts,
      this.imageURL,
      this.gymId,
      this.ownerId,
      this.name,
      this.description,
      this.location,
      this.isComplete,
      this.isWaiting);

  GymModel.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    faciltrs = json['faciltrs'];
    priceOndDay = double.parse(json['One Day'].toString());
    priceOndMonth = double.parse(json['One Month'].toString());
    priceThreeMonts = double.parse(json['Three Months'].toString());
    priceSixMonths = double.parse(json['Six Months'].toString());
    priceOneYear = double.parse(json['One Year'].toString());
    gymId = json['gymId'];
    imageURL = json['imageURL'];
    name = json['name'];
    description = json['descrption'];
    location = json['Location'];
    isWaiting = json['isWaiting'];
    isComplete = json['isComplete'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['images'] = this.images;
  //   data['faciltrs'] = this.faciltrs;
  //   data['price'] = this.priceOndDay;
  //   data['price'] = this.priceOndMonth;
  //   data['price'] = this.priceThreeMonts;
  //   data['price'] = this.priceSixMonths;
  //   data['price'] = this.priceOneYear;
  //   data['imageURL'] = this.imageURL;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['location'] = this.location;
  //   data['isFavorite'] = this.isFavorite;
  //   return data;
  // }
}
