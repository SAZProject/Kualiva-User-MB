import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/auth/repository/auth_repository.dart';
import 'package:kualiva/auth/repository/token_manager.dart';
import 'package:kualiva/data/current_location/current_location_bloc.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/data/search_bar/suggestion_repository.dart';
import 'package:kualiva/home/bloc/home_ad_banner_bloc.dart';
import 'package:kualiva/home/bloc/home_featured_bloc.dart';
import 'package:kualiva/home/cubit/home_search_bar_cubit.dart';
import 'package:kualiva/home/repository/promotion_repository.dart';
import 'package:kualiva/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/cubit/fnb_search_bar_cubit.dart';
import 'package:kualiva/places/fnb/repository/fnb_repository.dart';

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
        RepositoryProvider(create: (context) {
          final tokenManager = TokenManager(const FlutterSecureStorage(
            /// TODO For ios need more configuration
            /// https://pub.dev/packages/flutter_secure_storage
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          ));
          return tokenManager;
        }),
        RepositoryProvider(create: (context) {
          return DioClient(context.read<TokenManager>());
        }),
        RepositoryProvider(create: (context) {
          return FnbRepository(context.read<DioClient>());
        }),
        RepositoryProvider(create: (context) {
          return AuthRepository(
            context.read<TokenManager>(),
            context.read<DioClient>(),
          );
        }),
        RepositoryProvider(create: (context) {
          return PromotionRepository(
            context.read<DioClient>(),
          );
        }),
        RepositoryProvider(
          create: (context) {
            return SuggestionRepository();
          },
        )
      ],
      child: child,
    );
  }

  Widget _multiBloc(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AuthBloc(context.read<AuthRepository>());
        }),
        BlocProvider(create: (context) {
          return FnbNearestBloc(context.read<FnbRepository>());
        }),
        BlocProvider(create: (context) {
          return CurrentLocationBloc();
        }),
        BlocProvider(create: (context) {
          return FnbDetailBloc(context.read<FnbRepository>());
        }),
        BlocProvider(create: (context) {
          return HomeAdBannerBloc(context.read<PromotionRepository>());
        }),
        BlocProvider(create: (context) {
          return HomeSearchBarCubit(context.read<SuggestionRepository>());
        }),
        BlocProvider(create: (context) {
          return FnbSearchBarCubit(context.read<SuggestionRepository>());
        }),
        BlocProvider(create: (context) {
          return HomeFeaturedBloc(context.read<PromotionRepository>());
        })
      ],
      child: child,
    );
  }
}
