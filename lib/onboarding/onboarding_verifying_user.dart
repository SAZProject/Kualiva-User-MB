import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/style/custom_btn_style.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/widget/custom_elevated_button.dart';
import 'package:kualiva/_data/model/ui_model/onboarding_verifying_model.dart';
import 'package:kualiva/_data/model/ui_model/profile_menu_model.dart';
import 'package:kualiva/onboarding/widget/onboarding_pick_birthdate.dart';
import 'package:kualiva/onboarding/widget/onboarding_pick_notification.dart';

class OnboardingVerifyingUser extends StatefulWidget {
  const OnboardingVerifyingUser({super.key});

  @override
  State<OnboardingVerifyingUser> createState() =>
      _OnboardingVerifyingUserState();
}

class _OnboardingVerifyingUserState extends State<OnboardingVerifyingUser> {
  final List<OnboardingVerifyingModel> _pages = [
    const OnboardingVerifyingModel(
      icon: Icons.calendar_month,
      pageTitle: "onboard.onboard_pick_birthdate",
    ),
    // const OnboardingModel(
    //   icon: Icons.star,
    //   pageTitle: "onboard.onboard_pick_cuisine",
    // ),
    const OnboardingVerifyingModel(
      icon: Icons.notifications,
      pageTitle: "onboard.onboard_pick_notif",
    ),
  ];

  final PageController _pageController = PageController();

  int _activePage = 0;

  final _fullnameCtl = TextEditingController();
  DateTime? _selectedDate;

  // final FNBAssetModel _dummyCuisineData = FNBDataset.cuisineDataset;
  // Set<int> dummySelectedCuisine = {};

  final List<ProfileMenuModel> _listBtnItem = [
    ProfileMenuModel(
      imageUri: ImageConstant.appLogo,
      label: "onboard.onboard_pick_notif_item_1",
      isRightIcon: false,
      isCommingSoon: false,
    ),
    ProfileMenuModel(
      icon: Icons.call,
      label: "onboard.onboard_pick_notif_item_2",
      isRightIcon: false,
      isCommingSoon: false,
    ),
    ProfileMenuModel(
      icon: Icons.email,
      label: "onboard.onboard_pick_notif_item_3",
      isRightIcon: false,
      isCommingSoon: false,
    ),
  ];

  Set<int> selectedNotifChoice = {0};

  void _confirmBtnFunc(BuildContext context) {
    if (_activePage == 1) {
      Navigator.of(context).pushNamed(AppRoutes.devicePermissionScreen);
    } else {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  bool _fieldValidation(int page) {
    switch (page) {
      // TODO dimatikan untuk v1
      // case 1:
      //   if (dummySelectedCuisine.isEmpty) return false;
      //   return true;
      case 1:
        if (selectedNotifChoice.isEmpty) return false;
        return true;
      default:
        if (_selectedDate == null || _fullnameCtl.text.trim().isEmpty) {
          return false;
        }
        return true;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fullnameCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _pages.length,
      onPageChanged: (int page) {
        setState(() {
          _activePage = page;
        });
      },
      itemBuilder: (BuildContext ctx, int index) {
        return Column(
          children: [
            SizedBox(height: 25.h),
            _onBoardingHeader(context, _pages[index]),
            const Spacer(),
            _buildPage(context),
            const Spacer(flex: 2),
            _buildConfirm(context),
            SizedBox(height: 25.h),
          ],
        );
      },
    );
  }

  Widget _onBoardingHeader(
    BuildContext context,
    OnboardingVerifyingModel onboardingModel,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.tr(onboardingModel.pageTitle),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontSize: 30.fontSize,
                ),
          ),
          Icon(
            onboardingModel.icon,
            size: 40.h,
          ),
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    switch (_activePage) {
      // TODO dimatikan untuk V1
      // case 1:
      //   return OnboardingPickCuisine(
      //     cuisineData: _dummyCuisineData,
      //     selectedIndexes: dummySelectedCuisine,
      //     hintText: context.tr("onboard.onboard_pick_cuisine_hint"),
      //     onHintPressed: () {},
      //     onSelected: (index) {
      //       setState(() {
      //         if (dummySelectedCuisine.contains(index)) {
      //           dummySelectedCuisine.remove(index);
      //         } else {
      //           if (dummySelectedCuisine.length == 5) return;
      //           dummySelectedCuisine.add(index);
      //         }
      //       });
      //     },
      //   );
      case 1:
        return OnboardingPickNotification(
          listBtnItem: _listBtnItem,
          selectedIndexes: selectedNotifChoice,
          onSelectAll: () {
            Set<int> temp = {};
            for (int i = 0; i < _listBtnItem.length; i++) {
              temp.add(i);
            }
            setState(() {
              if (selectedNotifChoice.containsAll(temp)) {
                selectedNotifChoice.removeAll(temp);
              } else {
                selectedNotifChoice.addAll(temp);
              }
            });
          },
          onSelected: (index) {
            setState(() {
              if (selectedNotifChoice.contains(index)) {
                selectedNotifChoice.remove(index);
              } else {
                selectedNotifChoice.add(index);
              }
            });
          },
        );
      default:
        return OnboardingPickBirthdate(
          fullNameCtl: _fullnameCtl,
          fullNameHint: context.tr("onboard.onboard_fullname"),
          leftIcon: _selectedDate != null ? null : Icons.calendar_month,
          label: _selectedDate != null
              ? DatetimeUtils.dmy(_selectedDate!)
              : context.tr("onboard.onboard_pick_birthdate_btn_date"),
          hintText: context.tr("onboard.onboard_pick_birthdate_hint"),
          onHintPressed: () {},
          onPressed: () => _selectDate(context),
        );
    }
  }

  Widget _buildConfirm(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("onboard.onboard_confirm_btn"),
      secondText:
          _activePage == 1 ? context.tr("onboard.onboard_save_btn") : null,
      margin: EdgeInsets.all(10.h),
      buttonStyle: CustomButtonStyles.none,
      decoration: !_fieldValidation(_activePage)
          ? CustomDecoration(context).outline
          : CustomButtonStyles.gradientYellowAToPrimaryDecoration(context),
      buttonTextStyle: Theme.of(context).textTheme.titleLarge,
      onPressed: !_fieldValidation(_activePage)
          ? null
          : () => _confirmBtnFunc(context),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
