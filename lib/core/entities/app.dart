// ignore_for_file: public_member_api_docs, sort_constructors_first

class App {
  final String baseUrl;
  final String authBaseUrl;
  final String name;
  final String? phone;
  final String? email;
  final String logo;

  App({
    required this.baseUrl,
    required this.authBaseUrl,
    required this.name,
    this.phone,
    this.email,
    required this.logo,
  });
}
