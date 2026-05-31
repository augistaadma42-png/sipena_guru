import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../../../core/widgets/confirmation_dialog.dart';
import '../../../../core/widgets/main_layout.dart';
import '../widgets/panduan_jurnal_card.dart';
import '../widgets/buat_jurnal_form.dart';
import '../widgets/jurnal_terbaru_timeline.dart';
import 'rekap_jurnal_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/jurnal_entity.dart';
import '../bloc/jurnal_bloc.dart';
import '../bloc/jurnal_event.dart';
import '../bloc/jurnal_state.dart';
import '../../data/datasources/jurnal_local_datasource.dart';
import '../../data/repositories/jurnal_repository_impl.dart';
import '../../domain/usecases/get_jurnal_terbaru_usecase.dart';
import '../../domain/usecases/get_rekap_jurnal_usecase.dart';

class JurnalMengajarPage extends StatelessWidget {
  final Map<String, String>? initialData;

  const JurnalMengajarPage({Key? key, this.initialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _JurnalMengajarPageContent(initialData: initialData);
  }
}

class _JurnalMengajarPageContent extends StatefulWidget {
  final Map<String, String>? initialData;

  const _JurnalMengajarPageContent({Key? key, this.initialData})
      : super(key: key);

  @override
  State<_JurnalMengajarPageContent> createState() =>
      _JurnalMengajarPageContentState();
}

class _JurnalMengajarPageContentState
    extends State<_JurnalMengajarPageContent> {
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<BuatJurnalFormState>();
  Map<String, String>? _editingJurnalMap;
  Map<String, String>? _autoFillData;
  bool _editFromRekap = false;

  @override
  void initState() {
    super.initState();
    _autoFillData = widget.initialData;
  }

  /// Dipanggil saat tombol Edit ditekan di timeline atau rekap.
  /// Mengisi form dengan seluruh data jurnal termasuk mapel & tanggal.
  void _handleEditJurnal(JurnalEntity data, {bool fromRekap = false}) {
    setState(() {
      _editFromRekap = fromRekap;
      _editingJurnalMap = {
        'title': data.title,
        'className': data.className,
        'description': data.description,
        'mapel': data.mapel,
        'tanggal': data.tanggal,
        // Sertakan time agar info tambahan tetap tampil jika diperlukan
        'time': data.time,
      };
    });
    // Scroll ke form di bagian atas
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _cancelEdit() async {
    final shouldCancel = await showConfirmationDialog(
      context: context,
      title: 'Batalkan Perubahan?',
      message: 'Perubahan yang belum disimpan akan hilang. Apakah Anda yakin ingin kembali?',
      cancelText: 'Tetap di Halaman',
      confirmText: 'Kembali',
      isDestructive: true,
    );
    if (shouldCancel != true) return;

    setState(() {
      _editingJurnalMap = null;
    });
    if (_editFromRekap) {
      _editFromRekap = false;
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RekapJurnalPage(),
          ),
        );
      }
    }
  }

  Future<void> _handleSystemBack() async {
    final isEdit = _editingJurnalMap != null;
    final formIsDirty = _formKey.currentState?.isDirty ?? false;

    if (isEdit) {
      await _cancelEdit();
    } else if (formIsDirty) {
      final shouldCancel = await showConfirmationDialog(
        context: context,
        title: 'Batalkan Perubahan?',
        message: 'Perubahan yang belum disimpan akan hilang. Apakah Anda yakin ingin kembali?',
        cancelText: 'Tetap di Halaman',
        confirmText: 'Kembali',
        isDestructive: true,
      );
      if (shouldCancel == true && mounted) {
        _doBackNavigation();
      }
    } else {
      _doBackNavigation();
    }
  }

  void _doBackNavigation() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainLayout(initialIndex: 0),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = _editingJurnalMap != null;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _handleSystemBack();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: CustomAppBar(
          title: isEdit ? 'Edit Jurnal' : 'Jurnal Mengajar',
          showBackButton: isEdit,
          onBackTap: isEdit ? _cancelEdit : null,
        ),
        drawer: isEdit ? null : const CustomDrawer(),
        body: RefreshIndicator(
          color: AppColors.secondaryOrange,
          onRefresh: () async {
            context.read<JurnalBloc>().add(LoadJurnalTerbaruEvent());
            _formKey.currentState?.clearForm();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PanduanJurnalCard(),
                  const SizedBox(height: 20),
                  BuatJurnalForm(
                    key: _formKey,
                    initialData: _editingJurnalMap ?? _autoFillData,
                    onCancelEdit: _cancelEdit,
                    isEditMode: _editingJurnalMap != null,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<JurnalBloc, JurnalState>(
                    builder: (context, state) {
                      if (state is JurnalLoading || state is JurnalInitial) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (state is JurnalError) {
                        return Center(child: Text(state.message));
                      } else if (state is JurnalTerbaruLoaded) {
                        return JurnalTerbaruTimeline(
                          jurnalList: state.jurnalList,
                          onEditTap: _handleEditJurnal,
                          onLihatRekapTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RekapJurnalPage(),
                              ),
                            );

                            // Jika kembali dari rekap dengan data entity (Edit)
                            if (result != null && result is JurnalEntity) {
                              _handleEditJurnal(result, fromRekap: true);
                            }
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
