class ApiUrl {
  static const String baseUrl = 'http://localhost/toko_api/public';
  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduk = baseUrl + '/produk';
  static const String createProduk = baseUrl + '/produk';
  static const dataMember = baseUrl + '/user';

  static String updateProduk(int id) {
    return baseUrl + '/produk/' + id.toString() + '/update';
  }

  static String deleteProduk(String id) {
    return baseUrl + '/produk/' + id.toString() + '/delete';
  }

  static String getProduk(int id) {
    return baseUrl + '/produk/' + id.toString();
  }

  static String getProdukByKode(String kode) {
    return baseUrl + '/produk/kode/' + kode;
  }

  static String getProdukByNama(String nama) {
    return baseUrl + '/produk/nama/' + nama;
  }

  static String getProdukByHarga(int harga) {
    return baseUrl + '/produk/harga/' + harga.toString();
  }

  static String getUserData() {
    return baseUrl + '/user';
  }
}
