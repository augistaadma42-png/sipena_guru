import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/colors.dart';
import '../../data/datasources/daftar_kelas_local_datasource.dart';
import '../../data/repositories/daftar_kelas_repository_impl.dart';
import '../../domain/usecases/get_daftar_kelas_usecase.dart';
import '../bloc/daftar_kelas_bloc.dart';
import '../bloc/daftar_kelas_event.dart';
import '../bloc/daftar_kelas_state.dart';
import '../widgets/kelas_diampu_card.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_drawer.dart';

class DaftarKelasPage extends StatelessWidget {
  const DaftarKelasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final datasource = DaftarKelasLocalDatasourceImpl();
    final repository = DaftarKelasRepositoryImpl(localDatasource: datasource);

    return BlocProvider(
      create: (context) => DaftarKelasBloc(
        getDaftarKelas: GetDaftarKelasUsecase(repository),
      )..add(LoadDaftarKelasEvent()),
      child: const DaftarKelasView(),
    );
  }
}

class DaftarKelasView extends StatelessWidget {
  const DaftarKelasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(
        title: 'Kelas Diampu',
        showBackButton: false,
      ),
      body: BlocBuilder<DaftarKelasBloc, DaftarKelasState>(
        builder: (context, state) {
          if (state is DaftarKelasLoading || state is DaftarKelasInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is DaftarKelasError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is DaftarKelasLoaded) {
            if (state.kelasList.isEmpty) {
              return const Center(child: Text('Belum ada kelas yang diampu.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<DaftarKelasBloc>().add(LoadDaftarKelasEvent());
              },
              color: AppColors.primaryBlue,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.kelasList.length,
                itemBuilder: (context, index) {
                  return KelasDiampuCard(kelasDiampu: state.kelasList[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
