class UserRegister {
  final String nama;
  final String email;
  final String password;

  UserRegister({
    required this.nama,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'password': password,
    };
  }
}
