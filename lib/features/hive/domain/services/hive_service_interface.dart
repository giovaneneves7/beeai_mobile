import 'package:bee_ai/features/hive/domain/models/hive_model.dart';

abstract  class HiveServiceInterface{

  Future<HiveModel> saveHive(dynamic value);

}