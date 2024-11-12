
class HiveModel{

  int? id;
  int ip;

  HiveModel({required this.ip, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ip': ip,
    };
  }

  factory HiveModel.fromMap(Map<String, dynamic> map) {
    return HiveModel(
      id: map['id'],
      ip: map['ip'],
    );
  }
}