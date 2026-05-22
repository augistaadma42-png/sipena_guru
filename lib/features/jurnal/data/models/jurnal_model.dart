import '../../domain/entities/jurnal_entity.dart';

class JurnalModel extends JurnalEntity {
  const JurnalModel({
    required super.id,
    required super.className,
    required super.time,
    required super.title,
    required super.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'className': className,
      'time': time,
      'title': title,
      'description': description,
    };
  }
}
