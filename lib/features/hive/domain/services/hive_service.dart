import 'package:bee_ai/features/hive/domain/models/hive_model.dart';
import 'package:bee_ai/features/hive/domain/respositories/hive_repository.dart';
import 'package:bee_ai/features/hive/domain/services/hive_service_interface.dart';

class HiveService implements HiveServiceInterface{

  final HiveRepository hiveRepository = HiveRepository();

  @override
  Future<HiveModel> saveHive(value) async {

    if (value is! HiveModel) {
      throw ArgumentError('Expected value to be of type HiveModel');
    }

    await hiveRepository.add(value);
    return value;

  }

}