import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';

class CustomFloatModal extends StatelessWidget {
  const CustomFloatModal({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          theme(context).colorScheme.onSecondaryContainer.withOpacity(0.6),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Center(
      child: Container(
        color: theme(context).colorScheme.onSecondaryContainer,
        child: CustomImageView(
          height: 175.h,
          width: double.maxFinite,
          imagePath: imagePath,
          boxFit: BoxFit.contain,
        ),
      ),
    );
  }
}
