import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_it/data/dio_client.dart';

class MainProvider extends StatelessWidget {
  const MainProvider({super.key, required this.mainChild});

  final Widget mainChild;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DioClient()),
      ],
      child: mainChild,
    );
    // return mainChild;
    // MultiRepositoryProvider(
    //   providers: [],
    //   child: MultiBlocProvider(
    //     providers: [],
    //     child: mainChild,
    //   ),
    // );
  }
}
