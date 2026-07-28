class TodoDtoUser {
  final String username;
  final String email;
  final String phone;
  final String website;

  const TodoDtoUser({
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
  });

  factory TodoDtoUser.fromJson(Map<String, dynamic> json) {
    return TodoDtoUser(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
    );
  }
}
