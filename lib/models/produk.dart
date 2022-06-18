class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;
  String? gambarProduk;
  Produk({this.id, this.kodeProduk, this.namaProduk, this.hargaProduk, this.gambarProduk});
  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
        id: obj['id'],
        kodeProduk: obj['kode_produk'],
        gambarProduk: obj['gambar_produk'],
        namaProduk: obj['nama_produk'],
        hargaProduk: obj['harga']);
  }
}
