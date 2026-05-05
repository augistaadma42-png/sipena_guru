import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../widgets/jadwal_header_card.dart';
import '../widgets/jadwal_hari_section.dart';

class JadwalPelajaranPage extends StatefulWidget {
  const JadwalPelajaranPage({Key? key}) : super(key: key);

  @override
  State<JadwalPelajaranPage> createState() => _JadwalPelajaranPageState();
}

class _JadwalPelajaranPageState extends State<JadwalPelajaranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Jadwal Pelajaran'),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const JadwalHeaderCard(),
              const SizedBox(height: 24),
              const JadwalHariSection(
                hari: 'Senin',
                jumlahPelajaran: 2,
                jadwal: [
                  {
                    'jam': '07:00 - 08:30',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'XI-RPL 1',
                    'ruang': 'R.04',
                  },
                  {
                    'jam': '08:30 - 10:00',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'X-RPL 1',
                    'ruang': 'R.12',
                  },
                ],
              ),
              const SizedBox(height: 24),
              const JadwalHariSection(
                hari: 'Selasa',
                jumlahPelajaran: 2,
                warnaPil: AppColors.secondaryOrange,
                jadwal: [
                  {
                    'jam': '07:00 - 11:00',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'XI-RPL 2',
                    'ruang': 'Lab RPL 1',
                  },
                  {
                    'jam': '11:30 - 13:00',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'XI-TKJ 2',
                    'ruang': 'Lab TKJ 1',
                  },
                ],
              ),
              const SizedBox(height: 24),
              const JadwalHariSection(
                hari: 'Rabu',
                jumlahPelajaran: 1,
                jadwal: [
                  {
                    'jam': '07:00 - 08:30',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'X-TKJ 3',
                    'ruang': 'R.17',
                  },
                ],
              ),
              const SizedBox(height: 24),
              const JadwalHariSection(
                hari: 'Kamis',
                jumlahPelajaran: 1,
                warnaPil: AppColors.secondaryOrange,
                jadwal: [
                  {
                    'jam': '07:00 - 12:00',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'XI-ULW 1',
                    'ruang': 'R.54',
                  },
                ],
              ),
              const SizedBox(height: 24),
              const JadwalHariSection(
                hari: 'Jumat',
                jumlahPelajaran: 2,
                jadwal: [
                  {
                    'jam': '07:00 - 08:30',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'XI-BD 1',
                    'ruang': 'R.40',
                  },
                  {
                    'jam': '08:30 - 10:00',
                    'mataPelajaran': 'Bahasa Indonesia',
                    'kelas': 'XI-MP 2',
                    'ruang': 'R.19',
                  },
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
