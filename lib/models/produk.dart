class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;
  String? deskripsi;
  String? kategori;
  String? gambarProduk;
  Produk(
      {this.id,
      this.kodeProduk,
      this.namaProduk,
      this.hargaProduk,
      this.deskripsi,
      this.kategori,
      this.gambarProduk});
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
}
