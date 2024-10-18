class PaketWisata {
  final int id;
  final String package;
  final int price;
  final String activities;

  PaketWisata({
    required this.id,
    required this.package,
    required this.price,
    required this.activities,
  });

  factory PaketWisata.fromJson(Map<String, dynamic> json) {
    return PaketWisata(
      id: json['id'],
      package: json['package'],
      price: int.tryParse(json['price'].toString()) ?? 0,  // Menangani jika price dikirim sebagai string
      activities: json['activities'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package': package,
      'price': price,
      'activities': activities,
    };
  }
}
