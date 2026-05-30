class AbsenDraftCache {
  static String? selectedKelas;
  static bool? tandaiSemuaHadir;
  static final Map<String, String> studentStatusMap = {};
  static final Set<String> userModifiedStudentIds = {};

  static void reset() {
    selectedKelas = null;
    tandaiSemuaHadir = null;
    studentStatusMap.clear();
    userModifiedStudentIds.clear();
  }
}
