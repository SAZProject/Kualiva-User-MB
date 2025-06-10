import 'package:flutter/material.dart';
import 'package:kualiva/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimeCelestialHandler {
  static late PrimeCelestialCubit _cubit;

  static void init(PrimeCelestialCubit cubit) {
    _cubit = cubit;
  }

  static void show(String message) {
    _cubit.failure(message);
  }
}

class PrimeCelestialCubit extends Cubit<String?> {
  PrimeCelestialCubit() : super(null);

  void failure(String message) {
    emit(message);
  }

  void clear() {
    emit(null);
  }
}

class PrimeCelestial extends StatelessWidget {
  const PrimeCelestial({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TODO Create global bloc for dialog, snackbar, failure handler, point dialog, etc in main.dart
        // BlocBuilder(
        //   builder: (context, state) {
        //     return SizedBox();
        //   },
        // ),
        BlocListener<PrimeCelestialCubit, String?>(
          listenWhen: (previous, current) {
            return current != null;
          },
          listener: (context, state) {
            if (state == null) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state)));
            context.read<PrimeCelestialCubit>().clear();
          },
        ),
        SplashScreen(),
      ],
    );
  }
}
