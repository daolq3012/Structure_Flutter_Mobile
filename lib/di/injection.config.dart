// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:structure_flutter_mobile/core/middleware/dio_client.dart';
import 'package:structure_flutter_mobile/core/utils/constant.dart';

import '../bloc/blocs/user_bloc.dart';
import '../repositories/user_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);

  // Eager singletons must be registered in the right order
  gh.singleton<DioClient>(DioClient(Constants.BASE_URL, Dio()));
  gh.singleton<UserRepository>(UserRepositoryImpl(get<DioClient>()));
  gh.singleton<UserGitBloc>(UserGitBloc());
  return get;
}
