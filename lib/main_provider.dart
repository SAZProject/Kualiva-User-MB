import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/data/dio_client.dart';
import 'package:like_it/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:like_it/places/fnb/repository/fnb_repository.dart';

class MainProvider extends StatelessWidget {
  const MainProvider({super.key, required this.mainChild});

  final Widget mainChild;

  @override
  Widget build(BuildContext context) {
    return _multiRepository(_multiBloc(mainChild));
  }

  Widget _multiRepository(Widget child) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(lazy: false, create: (_) => DioClient()),
        RepositoryProvider(create: (context) {
          return FnbRepository(context.read<DioClient>());
        })
      ],
      child: child,
    );
  }

  Widget _multiBloc(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return FnbNearestBloc(context.read<FnbRepository>());
        })
      ],
      child: child,
    );
  }
}
