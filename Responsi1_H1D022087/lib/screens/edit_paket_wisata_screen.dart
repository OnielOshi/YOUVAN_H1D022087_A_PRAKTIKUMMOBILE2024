import 'package:flutter/material.dart';
import '../models/paket_wisata.dart';
import '../services/api_service.dart';

class EditPaketWisataScreen extends StatefulWidget {
  final PaketWisata paket;

  EditPaketWisataScreen({required this.paket});

  @override
  _EditPaketWisataScreenState createState() => _EditPaketWisataScreenState();
}

class _EditPaketWisataScreenState extends State<EditPaketWisataScreen> {
  final _formKey = GlobalKey<FormState>();
  late String package;
  late int price;
  late String activities;

  @override
  void initState() {
    super.initState();
    package = widget.paket.package;
    price = widget.paket.price;
    activities = widget.paket.activities;
  }

  void _updatePackage() async {
    if (_formKey.currentState!.validate()) {
      PaketWisata updatedPackage = PaketWisata(
        id: widget.paket.id,
        package: package,
        price: price,
        activities: activities,
      );

      try {
        await ApiService().updatePaketWisata(widget.paket.id, updatedPackage);

        await _showDialog('Berhasil', 'Paket wisata berhasil diperbarui!');

        Navigator.pop(context, true);
      } catch (e) {
        await _showDialog('Gagal', 'Paket wisata gagal diperbarui: $e');
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
                Navigator.of(context).pop();
              },
              child: Text('Oke'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Paket Wisata')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: package,
                decoration: InputDecoration(labelText: 'Nama Paket'),
                onChanged: (value) => package = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama paket tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                onChanged: (value) => price = int.parse(value),
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
                initialValue: activities,
                decoration: InputDecoration(labelText: 'Kegiatan'),
                onChanged: (value) => activities = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Kegiatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updatePackage,
                child: Text('Update', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFB2DFDB),
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
