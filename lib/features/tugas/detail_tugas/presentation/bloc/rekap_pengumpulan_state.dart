import 'package:equatable/equatable.dart';
import '../../domain/entities/assignment_recap_entity.dart';
import '../../domain/entities/assignment_submission_entity.dart';

abstract class RekapPengumpulanState extends Equatable {
  const RekapPengumpulanState();

  @override
  List<Object?> get props => [];
}

class RekapPengumpulanInitial extends RekapPengumpulanState {}

class RekapPengumpulanLoading extends RekapPengumpulanState {}

class RekapPengumpulanLoaded extends RekapPengumpulanState {
  final AssignmentRecapEntity recap;
  final List<AssignmentSubmissionEntity> filteredSubmissions;
  final bool showSubmitted; // filter aktif
  final String searchQuery;

  const RekapPengumpulanLoaded({
    required this.recap,
    required this.filteredSubmissions,
    this.showSubmitted = true,
    this.searchQuery = '',
  });

  RekapPengumpulanLoaded copyWith({
    AssignmentRecapEntity? recap,
    List<AssignmentSubmissionEntity>? filteredSubmissions,
    bool? showSubmitted,
    String? searchQuery,
  }) {
    return RekapPengumpulanLoaded(
      recap: recap ?? this.recap,
      filteredSubmissions: filteredSubmissions ?? this.filteredSubmissions,
      showSubmitted: showSubmitted ?? this.showSubmitted,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [recap, filteredSubmissions, showSubmitted, searchQuery];
}

class RekapPengumpulanEmpty extends RekapPengumpulanState {}

class RekapPengumpulanError extends RekapPengumpulanState {
  final String message;
  const RekapPengumpulanError(this.message);

  @override
  List<Object?> get props => [message];
}
