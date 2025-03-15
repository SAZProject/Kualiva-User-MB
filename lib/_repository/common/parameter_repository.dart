import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/_data/enum/parameter_enum.dart';

class ParameterRepository {
  ParameterRepository(this._dioClient);
  final DioClient _dioClient;

  Future<ParameterModel> get(
    ParameterEnum parameterEnum,
  ) async {
    final parameterBox = Hive.box<ParameterModel>(MyHive.parameter.name);

    final parameterHive = parameterBox.get(parameterEnum.toHiveKey());
    if (parameterHive != null) return parameterHive;

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/parameters/div-and-subdiv',
        queryParameters: parameterEnum.toMap(),
      );
    });

    final data = ParameterModel.fromMap(res.data);
    parameterBox.put(parameterEnum.toHiveKey(), data);

    return data;
  }

  Future<void> deleteHiveById(
    ParameterEnum parameterEnum,
  ) async {
    final parameterBox = Hive.box<ParameterModel>(MyHive.parameter.name);

    return await parameterBox.delete(parameterEnum.toHiveKey());
  }
}
