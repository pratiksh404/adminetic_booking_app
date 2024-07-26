class User {
  final int id;
  final String name;
  final String email;
  final String? fcmToken;

  User(
      {required this.id,
      required this.name,
      required this.email,
      this.fcmToken});
}
