import 'package:flutter/material.dart';
import '../models/paket_wisata.dart';
import '../services/api_service.dart';

class CreatePaketWisataScreen extends StatefulWidget {
  @override
  _CreatePaketWisataScreenState createState() => _CreatePaketWisataScreenState();
}

class _CreatePaketWisataScreenState extends State<CreatePaketWisataScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _packageController = TextEditingController();
  final TextEditingController _activitiesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _createPackage() async {
    if (_formKey.currentState!.validate()) {
      PaketWisata newPackage = PaketWisata(
        id: 0, // ID bisa diset nanti setelah mendapatkan dari API
        package: _packageController.text,
        price: int.parse(_priceController.text), // Pastikan mengonversi ke integer
        activities: _activitiesController.text,
      );

      try {
        await ApiService().createPaketWisata(newPackage);
        
        // Tampilkan dialog berhasil
        await _showDialog('Berhasil', 'Paket wisata berhasil ditambahkan!');
        // Arahkan kembali ke halaman daftar paket setelah dialog ditutup
        Navigator.pop(context, true); // Mengirim nilai true untuk menandakan berhasil
      } catch (e) {
        // Tampilkan dialog gagal
        await _showDialog('Gagal', 'Paket wisata gagal ditambahkan. Silakan coba lagi.');
      }
    }
  }

  Future<void> _showDialog(String title, String content) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Oke'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _packageController.dispose();
    _activitiesController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Paket Wisata')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _packageController,
                decoration: InputDecoration(labelText: 'Nama Paket'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama paket tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Harga harus berupa angka positif';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _activitiesController,
                decoration: InputDecoration(labelText: 'Kegiatan'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kegiatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _createPackage,
                child: Text('Tambah', style: TextStyle(color: Colors.white)), // Teks berwarna putih
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFFB2DFDB), minimumSize: Size(double.infinity, 48), // Warna teks tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Membuat sudut tombol lebih membulat
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
