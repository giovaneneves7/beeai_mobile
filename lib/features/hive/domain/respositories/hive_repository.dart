import 'package:bee_ai/interfaces/repository_interface.dart';
import 'package:bee_ai/features/hive/domain/models/hive_model.dart';
import 'package:bee_ai/features/database/domain/services/database_service.dart';

class HiveRepository implements RepositoryInterface{

  final DatabaseService _databaseService = DatabaseService();

  @override
  Future<void> add(dynamic hive) async {
    await _databaseService.insert('hives', hive.toMap());
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset}) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    throw UnimplementedError();
  }

}