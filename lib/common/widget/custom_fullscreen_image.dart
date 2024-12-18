import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/image_utility.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class CustomFullscreenImage extends StatefulWidget {
  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final String id;
  final List<String> listMediaFile;
  final Axis scrollDirection;

  CustomFullscreenImage({
    super.key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.id,
    required this.listMediaFile,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  @override
  State<StatefulWidget> createState() => FullscreenImageState();
}

class FullscreenImageState extends State<CustomFullscreenImage> {
  @override
  void dispose() {
    widget.pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.listMediaFile.length,
                loadingBuilder: widget.loadingBuilder,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: (page) {},
                scrollDirection: widget.scrollDirection,
              ),
              Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.h),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.cancel_outlined,
                          size: 25.h,
                          color: theme(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.image_not_supported),
        );
      },
      imageProvider: ImageUtility().getImageType(widget.listMediaFile[index]),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
      heroAttributes: PhotoViewHeroAttributes(tag: "$widget.id$index"),
    );
  }
}
