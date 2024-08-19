import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/utility/image_constant.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/sizd_spacer.dart';
import 'package:like_it/data/model/onboarding_model.dart';

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
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: _body(),
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
          sizedSpacer(context: context, height: 25.0),
        ],
      ),
    );
  }

  Widget onBoardingPage(OnboardingModel onboardingModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedSpacer(context: context, height: 20.0),
          Image.asset(
            onboardingModel.imageUri,
            height: 300.0,
            width: 300.0,
            fit: BoxFit.cover,
          ),
          sizedSpacer(context: context, height: 5.0),
          Text(
            context.tr(onboardingModel.title),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
          ),
          sizedSpacer(context: context, height: 5.0),
          Opacity(
            opacity: 0.6,
            child: Text(
              context.tr(onboardingModel.content),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          sizedSpacer(context: context, height: 5.0),
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
      height: 4,
      width: 50,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      text: context.tr("onboard.onboard_next_btn"),
      margin: const EdgeInsets.all(10.0),
      // buttonTextStyle: CustomTextyle.kBtn,
      onPressed: () {
        if (_activePage == 2) {
        } else {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut);
        }
      },
    );
  }
}
