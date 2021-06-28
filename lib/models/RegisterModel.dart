class RegisterModelUser {
  RegisterModelUser({
    this.name,
    this.phone,
    this.email,
    this.uid,
    this.image,
    this.cover,
    this.bio,
  });

  String name;
  String phone;
  String email;
  String uid;
  String image;
  String cover;
  String bio;
  factory RegisterModelUser.fromJson(Map<String, dynamic> json) =>
      RegisterModelUser(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        uid: json["uid"],
        image: json["image"],
        cover: json["cover"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "uid": uid,
        "image": image,
        "cover": cover,
        "bio": bio,
      };
}
