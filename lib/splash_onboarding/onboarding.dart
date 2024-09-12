import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/data/model/ui_model/onboarding_model.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<OnboardingModel> _pages = [
    OnboardingModel(
      imageUri: ImageConstant.onBoarding1,
      title: "onboard.onboard_1_title",
      content: "onboard.onboard_1_content",
      pageColor: const Color(0xFF04CCFF),
    ),
    OnboardingModel(
      imageUri: ImageConstant.onBoarding2,
      title: "onboard.onboard_2_title",
      content: "onboard.onboard_2_content",
      pageColor: const Color(0xFF73FF2D),
    ),
    OnboardingModel(
      imageUri: ImageConstant.onBoarding3,
      title: "onboard.onboard_3_title",
      content: "onboard.onboard_3_content",
      pageColor: const Color(0xFFFFDD00),
    ),
  ];

  final PageController _pageController = PageController();

  int _activePage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0.5, 0),
              end: const Alignment(1, 1),
              colors: [
                _activePage == 0
                    ? _pages[0].pageColor
                    : _activePage == 1
                        ? _pages[1].pageColor
                        : _pages[2].pageColor,
                theme(context).colorScheme.onSecondaryContainer,
              ],
            ),
          ),
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Flexible(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return onBoardingPage(_pages[0]);
                  case 1:
                    return onBoardingPage(_pages[1]);
                  case 2:
                    return onBoardingPage(_pages[2]);
                }
                return onBoardingPage(_pages[0]);
              },
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _buildIndicator(),
              ),
              _buildNext(context)
            ],
          ),
          SizedBox(height: 25.h),
        ],
      ),
    );
  }

  Widget onBoardingPage(OnboardingModel onboardingModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Image.asset(
            onboardingModel.imageUri,
            height: 300.h,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20.h),
          Text(
            context.tr(onboardingModel.title),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: 20.h),
          Opacity(
            opacity: 0.6,
            child: Text(
              context.tr(onboardingModel.content),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  //Indicator Builder
  List<Widget> _buildIndicator() {
    List<Widget> indicators = List<Widget>.generate(3, (index) {
      return _pageIndicators(index);
    });
    return indicators;
  }

  Widget _pageIndicators(int index) {
    final Color color;
    if (_activePage == index) {
      color = const Color(0xFFCCCCCC);
    } else {
      color = Colors.grey.shade100;
    }

    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 25.h,
      width: _activePage == index ? 30.h : 25.h,
      margin: EdgeInsets.only(right: 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.h),
        color: _activePage == index ? null : color,
        gradient: _activePage == index
            ? const LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFFFDD00), Color(0xFFFFAE00)],
              )
            : null,
      ),
    );
  }

  Widget _buildNext(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("onboard.onboard_next_btn"),
      secondText:
          _activePage == 2 ? context.tr("onboard.onboard_start_btn") : null,
      margin: EdgeInsets.all(10.h),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientYellowAToPrimaryDecoration(context),
      buttonTextStyle: Theme.of(context).textTheme.titleLarge,
      onPressed: () {
        if (_activePage == 2) {
          Navigator.of(context).pushNamed(AppRoutes.signInScreen);
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        }
      },
    );
  }
}
