class ProfileData {
  static final ProfileData _instance = ProfileData._internal();
  factory ProfileData() => _instance;
  ProfileData._internal();

  String name = "use";
  String email = "use@gmail.com";
  String phone = "+91 387832783";
  String location = "India";
  String profileImage =
      "https://via.placeholder.com/150x150.png?text=Profile+Pic";
}
