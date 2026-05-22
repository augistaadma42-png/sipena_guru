import '../../domain/entities/jam_slot_entity.dart';

class JamSlotModel extends JamSlotEntity {
  const JamSlotModel({
    required super.label,
    required super.jamSenKam,
    required super.jamJumat,
    super.isIstirahat,
  });

  factory JamSlotModel.fromJson(Map<String, dynamic> json) {
    return JamSlotModel(
      label: json['label'] as String,
      jamSenKam: json['jamSenKam'] as String,
      jamJumat: json['jamJumat'] as String,
      isIstirahat: (json['isIstirahat'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'jamSenKam': jamSenKam,
      'jamJumat': jamJumat,
      'isIstirahat': isIstirahat,
    };
  }
}
