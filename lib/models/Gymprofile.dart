class GymProfile {
  String? OwnerName;
  String? OwnerImage;
   late double  price ;  
  late String des ; 

  GymProfile(
    this.OwnerName,
    this.OwnerImage,
    this.price , 
    this.des
  );

  GymProfile.fromJson(Map<String, dynamic> json) {
    OwnerName = json['name'];
    OwnerImage = json['ImageURL'];
     price = json['price'].t;
      des = json['descrption'];
      
  }
}
