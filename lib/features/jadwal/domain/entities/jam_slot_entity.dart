class JamSlotEntity {
  final String label;
  final String jamSenKam;
  final String jamJumat;
  final bool isIstirahat;

  const JamSlotEntity({
    required this.label,
    required this.jamSenKam,
    required this.jamJumat,
    this.isIstirahat = false,
  });
}
