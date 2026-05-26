import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_drawer.dart';
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
    return BlocProvider(
      create: (context) {
        final ds = JurnalLocalDatasourceImpl();
        final repo = JurnalRepositoryImpl(localDatasource: ds);
        return JurnalBloc(
          getJurnalTerbaruUsecase: GetJurnalTerbaruUsecase(repo),
          getRekapJurnalUsecase: GetRekapJurnalUsecase(repo),
        )..add(LoadJurnalTerbaruEvent());
      },
      child: _JurnalMengajarPageContent(initialData: initialData),
    );
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
  Map<String, String>? _editingJurnalMap;
  Map<String, String>? _autoFillData;

  @override
  void initState() {
    super.initState();
    _autoFillData = widget.initialData;
  }

  void _handleEditJurnal(JurnalEntity data) {
    setState(() {
      _editingJurnalMap = {
        'title': data.title,
        'className': data.className,
        'description': data.description,
      };
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
      _editingJurnalMap = null;
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
      body: RefreshIndicator(
        color: AppColors.secondaryOrange,

        onRefresh: () async {
          context.read<JurnalBloc>().add(LoadJurnalTerbaruEvent());
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
                  initialData: _editingJurnalMap ?? _autoFillData,
                  onCancelEdit: _cancelEdit,
                  isEditMode: _editingJurnalMap != null,
                ),
                const SizedBox(height: 20),
                BlocBuilder<JurnalBloc, JurnalState>(
                  builder: (context, state) {
                    if (state is JurnalLoading || state is JurnalInitial) {
                      return const Center(child: CircularProgressIndicator());
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
                              builder: (context) => const RekapJurnalPage(),
                            ),
                          );

                          // Jika kembali dari Rekap Jurnal dengan membawa data (artinya tombol Edit ditekan)
                          if (result != null && result is JurnalEntity) {
                            _handleEditJurnal(result);
                          }
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 80), // Padding for bottom nav bar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
