class ApiUrl {
  static const String baseUrl = 'http://localhost/toko_api/public';
  static const String registrasi = '$baseUrl/registrasi';
  static const String login = '$baseUrl/login';
  static const String listProduk = '$baseUrl/produk';
  static const String listUsers = '$baseUrl/users';
  static const String addProduk = '$baseUrl/produk';

  static String updateProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String deleteProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String getProduk(int id) {
    return '$baseUrl/produk/$id';
  }

  static String getProdukByKode(String kode) {
    return '$baseUrl/produk/kode/$kode';
  }

  static String getProdukByNama(String nama) {
    return '$baseUrl/produk/nama/$nama';
  }

  static String getProdukByHarga(int harga) {
    return '$baseUrl/produk/harga/$harga';
  }

  static String getUserData(int id) {
    return '$baseUrl/users/$id';
  }
}
