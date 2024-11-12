import 'package:bee_ai/features/hive/domain/models/hive_model.dart';
import 'package:bee_ai/features/hive/domain/services/hive_service.dart';
import 'package:bee_ai/features/hive/domain/services/hive_service_interface.dart';

class HiveController{

  final HiveServiceInterface hiveService = HiveService();

  String? hiveIp;
  HiveModel? hive;

  Future<void> setHiveIp(dynamic hiveIp) async{

    this.hiveIp = hiveIp;

  }

  Future<void> saveHive(dynamic hive) async{

    this.hive = await hiveService.saveHive(hive);

  }

}