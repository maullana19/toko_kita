class Produk {
  int? id;
  int? code;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;
  String? deskripsi;
  String? kategori;
  String? gambarProduk;
  String? message;
  Produk(
      {this.id,
      this.code,
      this.kodeProduk,
      this.namaProduk,
      this.hargaProduk,
      this.deskripsi,
      this.kategori,
      this.gambarProduk,
      this.message});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      id: obj['id'],
      kodeProduk: obj['kode_produk'],
      gambarProduk: obj['gambar_produk'],
      namaProduk: obj['nama_produk'],
      hargaProduk: obj['harga'],
      deskripsi: obj['deskripsi'],
      kategori: obj['kategori'],
    );
  }
  factory Produk.success(Map<String, dynamic> obj) {
    return Produk(
      code: obj['code'],
      message: obj['data'],
    );
  }
  factory Produk.error(Map<String, dynamic> obj) {
    return Produk(
      message: obj['data'],
      code: obj['code'],
    );
  }
}
