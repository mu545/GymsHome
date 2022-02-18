class ProfileModel {
  String? userName;
  String? userImage;

  ProfileModel(
    this.userName,
    this.userImage,
  );

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userName = json['name'];
    userImage = json['url'];
  }
}
