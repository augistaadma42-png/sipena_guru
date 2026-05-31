import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart' show FlutterQuillLocalizations;
import 'core/constants/colors.dart';
import 'core/widgets/main_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/bloc/dashboard_event.dart';
import 'features/dashboard/data/datasources/dashboard_local_datasource.dart';
import 'features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'features/dashboard/domain/usecases/get_aktivitas_terbaru_usecase.dart';
import 'features/dashboard/domain/usecases/get_task_summary_usecase.dart';
import 'features/dashboard/domain/usecases/get_attendance_overview_usecase.dart';

import 'features/jurnal/presentation/bloc/jurnal_bloc.dart';
import 'features/jurnal/presentation/bloc/jurnal_event.dart';
import 'features/jurnal/data/datasources/jurnal_local_datasource.dart';
import 'features/jurnal/data/repositories/jurnal_repository_impl.dart';
import 'features/jurnal/domain/usecases/get_jurnal_terbaru_usecase.dart';
import 'features/jurnal/domain/usecases/get_rekap_jurnal_usecase.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (context) {
            final ds = DashboardLocalDatasourceImpl();
            final repo = DashboardRepositoryImpl(localDatasource: ds);
            return DashboardBloc(
              getAktivitasTerbaruUsecase: GetAktivitasTerbaruUsecase(repo),
              getTaskSummaryUsecase: GetTaskSummaryUsecase(repo),
              getAttendanceOverviewUsecase: GetAttendanceOverviewUsecase(repo),
            )..add(LoadDashboardDataEvent());
          },
        ),
        BlocProvider<JurnalBloc>(
          create: (context) {
            final ds = JurnalLocalDatasourceImpl();
            final repo = JurnalRepositoryImpl(localDatasource: ds);
            return JurnalBloc(
              getJurnalTerbaruUsecase: GetJurnalTerbaruUsecase(repo),
              getRekapJurnalUsecase: GetRekapJurnalUsecase(repo),
            )..add(LoadJurnalTerbaruEvent());
          },
        ),

      ],
      child: MaterialApp(
        title: 'Sipena Dashboard',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FlutterQuillLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('id', 'ID'),
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryBlue),
          useMaterial3: true,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const MainLayout(),
      ),
    );
  }
}