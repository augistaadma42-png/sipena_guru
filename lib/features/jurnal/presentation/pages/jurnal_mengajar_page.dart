import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../widgets/panduan_jurnal_card.dart';
import '../widgets/buat_jurnal_form.dart';
import '../widgets/jurnal_terbaru_timeline.dart';
import 'rekap_jurnal_page.dart';

class JurnalMengajarPage extends StatefulWidget {
  const JurnalMengajarPage({Key? key}) : super(key: key);

  @override
  State<JurnalMengajarPage> createState() => _JurnalMengajarPageState();
}

class _JurnalMengajarPageState extends State<JurnalMengajarPage> {
  final ScrollController _scrollController = ScrollController();
  Map<String, String>? _editingJurnalData;

  void _handleEditJurnal(Map<String, String> data) {
    setState(() {
      _editingJurnalData = data;
    });
    // Menggulir perlahan ke bagian atas tempat form berada
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _cancelEdit() {
    setState(() {
      _editingJurnalData = null;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomAppBar(title: 'Jurnal Mengajar'),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PanduanJurnalCard(),
              const SizedBox(height: 20),
              BuatJurnalForm(
                initialData: _editingJurnalData,
                onCancelEdit: _cancelEdit,
              ),
              const SizedBox(height: 20),
              JurnalTerbaruTimeline(
                onEditTap: _handleEditJurnal,
                onLihatRekapTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RekapJurnalPage(),
                    ),
                  );

                  // Jika kembali dari Rekap Jurnal dengan membawa data (artinya tombol Edit ditekan)
                  if (result != null && result is Map<String, String>) {
                    _handleEditJurnal(result);
                  }
                },
              ),
              const SizedBox(height: 80), // Padding for bottom nav bar
            ],
          ),
        ),
      ),
    );
  }
}
