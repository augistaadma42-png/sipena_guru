enum JenisNotif { absensi, tugasKumpul, tugasBelumDinilai, pengajuan }

class NotifikasiEntity {
  final String id;
  final String judul;
  final String isi;
  final JenisNotif jenis;
  final DateTime waktu;
  final bool dibaca;

  const NotifikasiEntity({
    required this.id,
    required this.judul,
    required this.isi,
    required this.jenis,
    required this.waktu,
    required this.dibaca,
  });
}
