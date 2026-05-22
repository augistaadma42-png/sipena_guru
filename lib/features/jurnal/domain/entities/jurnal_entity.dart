class JurnalEntity {
  final String id;
  final String className;
  final String time; // e.g. "Senin, 04 Mei 2026 | 07:00 - 08:30" or "07:00 - 08:00"
  final String title;
  final String description;

  const JurnalEntity({
    required this.id,
    required this.className,
    required this.time,
    required this.title,
    required this.description,
  });
}
