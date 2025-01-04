import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/repository/auth_repository.dart';
import 'package:kualiva/repository/token_manager.dart';
import 'package:kualiva/data/current_location/current_location_bloc.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/data/dio_client_minio.dart';
import 'package:kualiva/data/search_bar/suggestion_repository.dart';
import 'package:kualiva/data/upload_file/upload_file_bloc.dart';
import 'package:kualiva/data/upload_file/upload_file_repository.dart';
import 'package:kualiva/home/bloc/home_ad_banner_bloc.dart';
import 'package:kualiva/home/bloc/home_featured_bloc.dart';
import 'package:kualiva/home/cubit/home_search_bar_cubit.dart';
import 'package:kualiva/repository/promotion_repository.dart';
import 'package:kualiva/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/cubit/fnb_search_bar_cubit.dart';
import 'package:kualiva/repository/fnb_repository.dart';
import 'package:kualiva/places/hostelry/bloc/hotel_nearest_bloc.dart';
import 'package:kualiva/profile/bloc/user_profile_bloc.dart';
import 'package:kualiva/repository/profile_repository.dart';
import 'package:kualiva/report/bloc/report_place_bloc.dart';
import 'package:kualiva/repository/report_repository.dart';
import 'package:kualiva/review/bloc/review_place_create_bloc.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/bloc/review_place_read_bloc.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';
import 'package:kualiva/repository/review_repository.dart';

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
          return DioClientMinio(context.read<TokenManager>());
        }),
        RepositoryProvider(create: (context) {
          return FnbRepository(context.read<DioClient>());
        }),
        RepositoryProvider(create: (context) {
          return AuthRepository(
              context.read<TokenManager>(), context.read<DioClient>());
        }),
        RepositoryProvider(create: (context) {
          return PromotionRepository();
        }),
        RepositoryProvider(
          create: (context) {
            return SuggestionRepository();
          },
        ),
        RepositoryProvider(
          create: (context) {
            return ReportRepository(
                context.read<DioClient>(), context.read<DioClientMinio>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return UploadFileRepository(context.read<DioClient>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return ReviewRepository(context.read<DioClient>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return ProfileRepository(context.read<DioClient>());
          },
        ),
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
          return HotelNearestBloc(context.read<FnbRepository>());
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
        }),
        BlocProvider(create: (context) {
          return ReportPlaceBloc(context.read<ReportRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewSearchBarCubit(context.read<SuggestionRepository>());
        }),
        BlocProvider(create: (context) {
          return UploadFileBloc(context.read<UploadFileRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewPlaceOtherReadBloc(context.read<ReviewRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewPlaceMyReadBloc(context.read<ReviewRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewPlaceCreateBloc(context.read<ReviewRepository>());
        }),
        BlocProvider(
          create: (context) {
            return UserProfileBloc(context.read<ProfileRepository>());
          },
        )
      ],
      child: child,
    );
  }
}
