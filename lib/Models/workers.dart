// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Worker {
  final String uidWorkers;
  final String nameWorkers;
  final String ageworker;
  final String genderworker;
  final String mobileNoworker;
  final String maritalStatusworker;
  final String religionworker;
  final String monthlyIncomeworker;
  final String workExperienceworker;
  final String languageworker;
  Worker({
    required this.uidWorkers,
    required this.nameWorkers,
    required this.ageworker,
    required this.genderworker,
    required this.mobileNoworker,
    required this.maritalStatusworker,
    required this.religionworker,
    required this.monthlyIncomeworker,
    required this.workExperienceworker,
    required this.languageworker,
  });

  get addressWorker => null;
 

  Worker copyWith({
    String? uidWorkers,
    String? nameWorkers,
    String? ageworker,
    String? genderworker,
    String? mobileNoworker,
    String? maritalStatusworker,
    String? religionworker,
    String? monthlyIncomeworker,
    String? workExperienceworker,
    String? languageworker,
  }) {
    return Worker(
      uidWorkers: uidWorkers ?? this.uidWorkers,
      nameWorkers: nameWorkers ?? this.nameWorkers,
      ageworker: ageworker ?? this.ageworker,
      genderworker: genderworker ?? this.genderworker,
      mobileNoworker: mobileNoworker ?? this.mobileNoworker,
      maritalStatusworker: maritalStatusworker ?? this.maritalStatusworker,
      religionworker: religionworker ?? this.religionworker,
      monthlyIncomeworker: monthlyIncomeworker ?? this.monthlyIncomeworker,
      workExperienceworker: workExperienceworker ?? this.workExperienceworker,
      languageworker: languageworker ?? this.languageworker,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uidWorkers': uidWorkers,
      'nameWorkers': nameWorkers,
      'ageworker': ageworker,
      'genderworker': genderworker,
      'mobileNoworker': mobileNoworker,
      'maritalStatusworker': maritalStatusworker,
      'religionworker': religionworker,
      'monthlyIncomeworker': monthlyIncomeworker,
      'workExperienceworker': workExperienceworker,
      'languageworker': languageworker,
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      uidWorkers: map['uidWorkers'] as String,
      nameWorkers: map['nameWorkers'] as String,
      ageworker: map['ageworker'] as String,
      genderworker: map['genderworker'] as String,
      mobileNoworker: map['mobileNoworker'] as String,
      maritalStatusworker: map['maritalStatusworker'] as String,
      religionworker: map['religionworker'] as String,
      monthlyIncomeworker: map['monthlyIncomeworker'] as String,
      workExperienceworker: map['workExperienceworker'] as String,
      languageworker: map['languageworker'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Worker.fromJson(String source) => Worker.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Worker(uidWorkers: $uidWorkers, nameWorkers: $nameWorkers, ageworker: $ageworker, genderworker: $genderworker, mobileNoworker: $mobileNoworker, maritalStatusworker: $maritalStatusworker, religionworker: $religionworker, monthlyIncomeworker: $monthlyIncomeworker, workExperienceworker: $workExperienceworker, languageworker: $languageworker)';
  }

  @override
  bool operator ==(covariant Worker other) {
    if (identical(this, other)) return true;
  
    return 
      other.uidWorkers == uidWorkers &&
      other.nameWorkers == nameWorkers &&
      other.ageworker == ageworker &&
      other.genderworker == genderworker &&
      other.mobileNoworker == mobileNoworker &&
      other.maritalStatusworker == maritalStatusworker &&
      other.religionworker == religionworker &&
      other.monthlyIncomeworker == monthlyIncomeworker &&
      other.workExperienceworker == workExperienceworker &&
      other.languageworker == languageworker;
  }

  @override
  int get hashCode {
    return uidWorkers.hashCode ^
      nameWorkers.hashCode ^
      ageworker.hashCode ^
      genderworker.hashCode ^
      mobileNoworker.hashCode ^
      maritalStatusworker.hashCode ^
      religionworker.hashCode ^
      monthlyIncomeworker.hashCode ^
      workExperienceworker.hashCode ^
      languageworker.hashCode;
  }
}
