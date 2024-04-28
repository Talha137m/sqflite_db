// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StudentModelClass {
  int rollNo;
  double fee;
  String name;
  StudentModelClass({
    required this.rollNo,
    required this.fee,
    required this.name,
  });
  StudentModelClass copyWith({
    int? rollNo,
    double? fee,
    String? name,
  }) {
    return StudentModelClass(
      rollNo: rollNo ?? this.rollNo,
      fee: fee ?? this.fee,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rollNo': rollNo,
      'fee': fee,
      'name': name,
    };
  }

  factory StudentModelClass.fromMap(Map<String, dynamic> map) {
    return StudentModelClass(
      rollNo: map['rollNo'] as int,
      fee: map['fee'] as double,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentModelClass.fromJson(String source) =>
      StudentModelClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StudentModelClass(rollNo: $rollNo, fee: $fee, name: $name)';

  @override
  bool operator ==(covariant StudentModelClass other) {
    if (identical(this, other)) return true;

    return other.rollNo == rollNo && other.fee == fee && other.name == name;
  }

  @override
  int get hashCode => rollNo.hashCode ^ fee.hashCode ^ name.hashCode;
}
