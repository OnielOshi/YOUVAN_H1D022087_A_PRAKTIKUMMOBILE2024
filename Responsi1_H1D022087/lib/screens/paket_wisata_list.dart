import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/paket_wisata.dart';
import '../screens/edit_paket_wisata_screen.dart';
import '../screens/tambah_paket_wisata_screen.dart';

class PaketWisataList extends StatefulWidget {
  @override
  _PaketWisataListState createState() => _PaketWisataListState();
}

class _PaketWisataListState extends State<PaketWisataList> {
  late Future<List<PaketWisata>> paketList;

  @override
  void initState() {
    super.initState();
    paketList = ApiService().getPaketWisata();
  }

  void _navigateToEditScreen(PaketWisata paket) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPaketWisataScreen(paket: paket),
      ),
    ).then((_) {
      setState(() {
        paketList = ApiService().getPaketWisata();
      });
    });
  }

  void _addNewPackage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePaketWisataScreen(),
      ),
    ).then((_) {
      setState(() {
        paketList = ApiService().getPaketWisata();
      });
    });
  }

  Future<void> _confirmDelete(int id) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin menghapus paket ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                Navigator.of(context).pop();
                _deletePaketWisata(id);
              },
            ),
          ],
        );
      },
    );
  }

  void _deletePaketWisata(int id) async {
    try {
      await ApiService().deletePaketWisata(id);
      setState(() {
        paketList = ApiService().getPaketWisata();
      });
    } catch (e) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Gagal menghapus paket wisata: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('Tutup'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paket Wisata'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewPackage,
          ),
        ],
      ),
      body: FutureBuilder<List<PaketWisata>>(
        future: paketList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final paket = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      paket.package,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Kegiatan: ${paket.activities}\nHarga: Rp ${paket.price}',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    onTap: () {
                      _navigateToEditScreen(paket);
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(paket.id);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Center(child: Text('No data available'));
        },
      ),
    );
  }
}
