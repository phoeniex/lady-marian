import 'package:dio/dio.dart';
import 'package:marian/data/_shared/exception.dart';
import 'package:marian/data/task/dto/paging_dto.dart';
import 'package:marian/data/task/dto/task_dto.dart';
import 'package:marian/domain/_shared/entities/paging.dart';
import 'package:marian/domain/task/entities/task.dart';

abstract class TaskRemoteDataSource {
  Future<Paging<Task>> getTasks({int page = 0, int count = 10, String? status});
}

class TaskApiRemoteDataSource implements TaskRemoteDataSource {
  final dio = Dio();

  @override
  Future<Paging<Task>> getTasks({int page = 0, int count = 10, String? status}) async {
    final response = await dio.get('https://todo-list-api-mfchjooefq-as.a.run.app/todo-list', queryParameters: {
      'offset': page,
      'limit': count,
      'sortBy': 'createdAt',
      if(status != null) 'status': status
    });

    try {
      final objects = PagingDto<Task>.fromMap(response.data);
      final tasks = (response.data['tasks'] as List)
          .map((task) => TaskDto.fromMap(task))
          .toList();
      objects.items = tasks;
      return objects;
    } on DioException catch (error) {
      if (error.response?.statusCode != null) {
        throw ApiResponseException(statusCode: error.response!.statusCode!);
      } else {
        throw ApiGenericException(message: error.toString());
      }
    }
  }

}