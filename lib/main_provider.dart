import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kualiva/_repository/common/location_repository.dart';
import 'package:kualiva/_repository/common/minio_repository.dart';
import 'package:kualiva/_repository/place/fnb/fnb_nearest_repository.dart';
import 'package:kualiva/_repository/place/fnb/fnb_promo_repository.dart';
import 'package:kualiva/_repository/place/fnb/fnb_recommended_repository.dart';
import 'package:kualiva/_repository/place/nightlife_repository.dart';
import 'package:kualiva/_repository/user/onboarding_repository.dart';
import 'package:kualiva/_repository/common/parameter_repository.dart';
import 'package:kualiva/_repository/place/spa_repository.dart';
import 'package:kualiva/auth/bloc/auth_bloc.dart';
import 'package:kualiva/_repository/user/auth_repository.dart';
import 'package:kualiva/_repository/common/token_manager.dart';
import 'package:kualiva/common/cubit/search_bar_cubit.dart';
import 'package:kualiva/common/feature/current_location/current_location_bloc.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/dio_client_minio.dart';
import 'package:kualiva/_repository/common/recent_suggestion_repository.dart';
import 'package:kualiva/home/bloc/home_ad_banner_bloc.dart';
import 'package:kualiva/home/bloc/home_featured_bloc.dart';
import 'package:kualiva/_repository/promotion/promotion_repository.dart';
import 'package:kualiva/onboarding/bloc/onboarding_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_action_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_detail_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_nearest_bloc.dart';
import 'package:kualiva/places/fnb/bloc/fnb_promo_bloc.dart';
import 'package:kualiva/_repository/place/fnb_repository.dart';
import 'package:kualiva/places/fnb/bloc/fnb_recommended_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_detail_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_nearest_bloc.dart';
import 'package:kualiva/places/nightlife/bloc/nightlife_promo_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_detail_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_nearest_bloc.dart';
import 'package:kualiva/places/spa/bloc/spa_promo_bloc.dart';
import 'package:kualiva/profile/bloc/user_profile_bloc.dart';
import 'package:kualiva/_repository/user/profile_repository.dart';
import 'package:kualiva/report/bloc/report_place_bloc.dart';
import 'package:kualiva/_repository/common/report_repository.dart';
import 'package:kualiva/report/bloc/report_review_create_bloc.dart';
import 'package:kualiva/report/bloc/report_review_read_bloc.dart';
import 'package:kualiva/review/bloc/review_like_bloc.dart';
import 'package:kualiva/review/bloc/review_place_create_bloc.dart';
import 'package:kualiva/review/bloc/review_place_my_read_bloc.dart';
import 'package:kualiva/review/bloc/review_place_other_read_bloc.dart';
import 'package:kualiva/review/cubit/review_filter_cubit.dart';
import 'package:kualiva/review/cubit/review_search_bar_cubit.dart';
import 'package:kualiva/_repository/review/review_repository.dart';

class MainProvider extends StatelessWidget {
  const MainProvider({super.key, required this.mainChild});

  final Widget mainChild;

  // final GlobalKey<ScaffoldMessengerState> scaffoldMessagerKey =
  //     GlobalKey<ScaffoldMessengerState>();

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
          return DioClient(
            context.read<TokenManager>(),
            GlobalKey<ScaffoldMessengerState>(),
          );
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
          return SpaRepository(context.read<DioClient>());
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
            return RecentSuggestionRepository();
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
        ),
        RepositoryProvider(
          create: (context) {
            return FnbNearestRepository(context.read<DioClient>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return FnbPromoRepository(context.read<DioClient>());
          },
        ),
        RepositoryProvider(
          create: (context) {
            return FnbRecommendedRepository(context.read<DioClient>());
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
          return CurrentLocationBloc(context.read<LocationRepository>());
        }),
        BlocProvider(create: (context) {
          return FnbNearestBloc(context.read<FnbNearestRepository>());
        }),
        BlocProvider(create: (context) {
          return NightlifeNearestBloc(context.read<NightlifeRepository>());
        }),
        BlocProvider(create: (context) {
          return SpaNearestBloc(context.read<SpaRepository>());
        }),
        BlocProvider(create: (context) {
          return NightlifePromoBloc(context.read<NightlifeRepository>());
        }),
        BlocProvider(create: (context) {
          return SpaPromoBloc(context.read<SpaRepository>());
        }),
        BlocProvider(create: (context) {
          return FnbDetailBloc(context.read<FnbRepository>());
        }),
        BlocProvider(create: (context) {
          return NightlifeDetailBloc(context.read<NightlifeRepository>());
        }),
        BlocProvider(create: (context) {
          return SpaDetailBloc(context.read<SpaRepository>());
        }),
        BlocProvider(create: (context) {
          return HomeAdBannerBloc(context.read<PromotionRepository>());
        }),
        BlocProvider(create: (context) {
          return HomeFeaturedBloc(context.read<PromotionRepository>());
        }),
        BlocProvider(create: (context) {
          return SearchBarCubit(context.read<RecentSuggestionRepository>());
        }),
        BlocProvider(create: (context) {
          return ReportPlaceBloc(context.read<ReportRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewSearchBarCubit(
              context.read<RecentSuggestionRepository>());
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
        BlocProvider(create: (context) {
          return FnbPromoBloc(context.read<FnbPromoRepository>());
        }),
        BlocProvider(create: (context) {
          return NightlifePromoBloc(context.read<NightlifeRepository>());
        }),
        BlocProvider(create: (context) {
          return ReviewFilterCubit(
            context.read<ReviewRepository>(),
            context.read<RecentSuggestionRepository>(),
          );
        }),
        BlocProvider(
          create: (context) {
            return FnbActionBloc(
              context.read<FnbNearestRepository>(),
              context.read<FnbPromoRepository>(),
              context.read<FnbRecommendedRepository>(),
            );
          },
        ),
        BlocProvider(create: (context) {
          return FnbRecommendedBloc(context.read<FnbRecommendedRepository>());
        }),
      ],
      child: child,
    );
  }
}
