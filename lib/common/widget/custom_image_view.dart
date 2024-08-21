import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

extension ImageTypeExtension on String {
  ImageType get imagetype {
    if (startsWith("http") || startsWith("https")) {
      return ImageType.network;
    } else if (endsWith(".svg")) {
      return ImageType.svg;
    } else if (startsWith("file://")) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

class CustomImageView extends StatelessWidget {
  const CustomImageView(
      {super.key,
      required this.imagePath,
      this.height,
      this.width,
      this.color,
      this.boxFit,
      this.placeHolder = Icons.image_not_supported_outlined,
      this.alignment,
      this.onPressed,
      this.margin,
      this.radius,
      this.border});

  final String imagePath;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? boxFit;
  final IconData placeHolder;
  final Alignment? alignment;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? radius;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _imageViewWidget(),
          )
        : _imageViewWidget();
  }

  Widget _imageViewWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onPressed,
        child: _circleImageView(),
      ),
    );
  }

  _circleImageView() {
    if (radius != null) {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.zero,
        child: _imageViewWithBorder(),
      );
    } else {
      return _imageViewWithBorder();
    }
  }

  _imageViewWithBorder() {
    if (border != null) {
      return Container(
        decoration: BoxDecoration(
          border: border,
          borderRadius: radius,
        ),
        child: _imageView(),
      );
    } else {
      return _imageView();
    }
  }

  Widget _imageView() {
    switch (imagePath.imagetype) {
      case ImageType.svg:
        return SizedBox(
          height: height,
          width: width,
          child: SvgPicture.asset(
            imagePath,
            height: height,
            width: width,
            fit: boxFit ?? BoxFit.contain,
            colorFilter: color != null
                ? ColorFilter.mode(
                    color ?? Colors.transparent,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        );
      case ImageType.file:
        return Image.file(
          File(imagePath),
          height: height,
          width: width,
          fit: boxFit ?? BoxFit.cover,
          color: color,
        );
      case ImageType.network:
        return CachedNetworkImage(
          height: height,
          width: width,
          fit: boxFit,
          imageUrl: imagePath,
          color: color,
          placeholder: (context, url) => SizedBox(
            height: 30.0,
            width: 30.0,
            child: LinearProgressIndicator(
              color: Colors.grey.shade200,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
          errorWidget: (context, url, error) => SizedBox(
            height: height,
            width: width,
            child: FittedBox(
              fit: boxFit ?? BoxFit.cover,
              child: Icon(placeHolder),
            ),
          ),
        );
      case ImageType.png:
      default:
        return Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: boxFit ?? BoxFit.cover,
          color: color,
        );
    }
  }
}
