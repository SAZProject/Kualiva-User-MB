import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kualiva/_repository/location_repository.dart';
import 'package:kualiva/_repository/minio_repository.dart';
import 'package:kualiva/_repository/nightlife_repository.dart';
import 'package:kualiva/_repository/onboarding_repository.dart';
import 'package:kualiva/_repository/parameter_repository.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/_repository/auth_repository.dart';
import 'package:kualiva/_repository/token_manager.dart';
import 'package:kualiva/_data/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/dio_client_minio.dart';
import 'package:kualiva/_repository/suggestion_repository.dart';
import 'package:kualiva/_data/feature/upload_file/upload_file_bloc.dart';
import 'package:kualiva/_repository/upload_file_repository.dart';
import 'package:kualiva/home/bloc/home_ad_banner_bloc.dart';
import 'package:kualiva/home/bloc/home_featured_bloc.dart';
import 'package:kualiva/home/cubit/home_search_bar_cubit.dart';
import 'package:kualiva/_repository/promotion_repository.dart';
import 'package:kualiva/onboarding/bloc/onboarding_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/places/fnb/cubit/fnb_search_bar_cubit.dart';
import 'package:kualiva/_repository/fnb_repository.dart';
import 'package:kualiva/places/hostelry/bloc/hotel_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_detail_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/profile/bloc/user_profile_bloc.dart';
import 'package:kualiva/_repository/profile_repository.dart';
import 'package:kualiva/report/bloc/report_place_bloc.dart';
import 'package:kualiva/_repository/report_repository.dart';
import 'package:kualiva/report/bloc/report_review_create_bloc.dart';
import 'package:kualiva/report/bloc/report_review_read_bloc.dart';
import 'package:kualiva/review/bloc/review_like_bloc.dart';
import 'package:kualiva/review/bloc/review_place_create_bloc.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/bloc/review_place_other_read_bloc.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';
import 'package:kualiva/_repository/review_repository.dart';

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
        RepositoryProvider(
          create: (context) {
            return MinioRepository(context.read<DioClientMinio>());
          },
        ),
        RepositoryProvider(create: (context) {
          return FnbRepository(context.read<DioClient>());
        }),
        RepositoryProvider(create: (context) {
          return NightlifeRepository(context.read<DioClient>());
        }),
        RepositoryProvider(create: (context) {
          return AuthRepository(
            context.read<TokenManager>(),
            context.read<DioClient>(),
          );
        }),
        RepositoryProvider(
          create: (context) {
            return ParameterRepository(context.read<DioClient>());
          },
        ),
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
              context.read<DioClient>(),
              context.read<ParameterRepository>(),
              context.read<MinioRepository>(),
            );
          },
        ),
        RepositoryProvider(
          create: (context) {
            return UploadFileRepository(context.read<DioClient>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return ReviewRepository(
              context.read<DioClient>(),
              context.read<MinioRepository>(),
            );
          },
        ),
        RepositoryProvider(
          create: (context) {
            return ProfileRepository(
              context.read<DioClient>(),
              context.read<MinioRepository>(),
            );
          },
        ),
        RepositoryProvider(
          create: (context) {
            return OnboardingRepository(context.read<DioClient>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return LocationRepository();
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
          return OnboardingBloc(context.read<OnboardingRepository>());
        }),
        BlocProvider(create: (context) {
          return FnbNearestBloc(context.read<FnbRepository>());
        }),
        BlocProvider(create: (context) {
          return NightlifeNearestBloc(context.read<NightlifeRepository>());
        }),
        BlocProvider(create: (context) {
          return HotelNearestBloc(context.read<FnbRepository>());
        }),
        BlocProvider(create: (context) {
          return CurrentLocationBloc(context.read<LocationRepository>());
        }),
        BlocProvider(create: (context) {
          return FnbDetailBloc(context.read<FnbRepository>());
        }),
        BlocProvider(create: (context) {
          return NightlifeDetailBloc(context.read<NightlifeRepository>());
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
        BlocProvider(create: (context) {
          return UserProfileBloc(context.read<ProfileRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewLikeBloc(context.read<ReviewRepository>());
        }),
        BlocProvider(create: (context) {
          return ReportReviewReadBloc(context.read<ReportRepository>());
        }),
        BlocProvider(create: (context) {
          return ReportReviewCreateBloc(context.read<ReportRepository>());
        }),
        BlocProvider(
          create: (context) {
            return FnbPromoBloc(context.read<FnbRepository>());
          },
        ),
        BlocProvider(
          create: (context) {
            return NightlifePromoBloc(context.read<NightlifeRepository>());
          },
        )
      ],
      child: child,
    );
  }
}
