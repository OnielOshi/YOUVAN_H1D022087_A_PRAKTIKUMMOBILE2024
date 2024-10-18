import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:responsi_pariwisata/models/UserLogin.dart';
import 'package:responsi_pariwisata/models/UserRegister.dart';
import '../models/paket_wisata.dart';

class ApiService {
  final String baseUrl = 'http://responsi.webwizards.my.id/api'; 

  Future<void> login(UserLogin userLogin) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(userLogin.toJson()),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (responseData['status'] == true) {
      return;
    } else {
      throw Exception('Login gagal: ${responseData['message']}');
    }
  } else {
    throw Exception('Failed to login: ${response.body}');
  }
}

 Future<bool> register(UserRegister userRegister) async {
  final response = await http.post(
    Uri.parse('$baseUrl/registrasi'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(userRegister.toJson()),
  );

  final Map<String, dynamic> responseData = json.decode(response.body);

  if (response.statusCode == 200 && responseData['code'] == 201) {
    return true;
  } else {
    print('Registrasi gagal dengan status: ${response.statusCode}');
    throw Exception('Failed to register: ${response.body}');
  }
}

  Future<List<PaketWisata>> getPaketWisata() async {
    final response = await http.get(Uri.parse('$baseUrl/pariwisata/paket_wisata'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      Iterable list = responseData['data'];
      return list.map((model) => PaketWisata.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load paket wisata');
    }
  }

  Future<void> createPaketWisata(PaketWisata paket) async {
  final response = await http.post(
    Uri.parse('$baseUrl/pariwisata/paket_wisata'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(paket.toJson()),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200 || response.statusCode == 201) {
    return;
  } else {
    throw Exception('Failed to create paket wisata: ${response.body}');
  }
}

  Future<void> updatePaketWisata(int id, PaketWisata paket) async {
  final response = await http.put(
    Uri.parse('$baseUrl/pariwisata/paket_wisata/$id/update'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(paket.toJson()),
  );

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception('Failed to update paket wisata: ${response.body}');
  }
}

  Future<void> deletePaketWisata(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pariwisata/paket_wisata/$id/delete'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete paket wisata');
    }
  }
}
