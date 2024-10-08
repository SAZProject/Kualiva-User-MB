import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_outlined_button.dart';
import 'package:like_it/data/model/ui_model/profile_menu_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ProfileMenuModel> _profileMenuModel = [
    ProfileMenuModel(
        label: "profile.my_profile",
        icon: Icons.edit,
        isRightIcon: false,
        isCommingSoon: false),
    ProfileMenuModel(
        label: "profile.my_voucher",
        icon: Icons.card_giftcard,
        isRightIcon: false,
        isCommingSoon: true),
    ProfileMenuModel(
        label: "profile.saved",
        icon: Icons.favorite,
        isRightIcon: false,
        isCommingSoon: true),
    ProfileMenuModel(
        label: "profile.my_stats",
        icon: Icons.bar_chart,
        isRightIcon: false,
        isCommingSoon: true),
    ProfileMenuModel(
        label: "profile.my_reviews",
        icon: Icons.star,
        isRightIcon: false,
        isCommingSoon: true),
    ProfileMenuModel(
        label: "profile.notif",
        icon: Icons.notifications,
        isRightIcon: false,
        isCommingSoon: true),
    ProfileMenuModel(
        label: "profile.theme",
        icon: Icons.brightness_4_outlined,
        isRightIcon: true,
        isCommingSoon: false),
    ProfileMenuModel(
        label: "profile.lang",
        icon: Icons.language,
        isRightIcon: false,
        isCommingSoon: false),
    ProfileMenuModel(
        label: "profile.add_place",
        icon: Icons.add,
        isRightIcon: false,
        isCommingSoon: false),
    ProfileMenuModel(
        label: "profile.acc_setting",
        icon: Icons.lock_person,
        isRightIcon: false,
        isCommingSoon: false),
    ProfileMenuModel(
        label: "profile.customer_support",
        icon: Icons.support_agent,
        isRightIcon: false,
        isCommingSoon: true),
    ProfileMenuModel(
        label: "profile.about_us",
        imageUri: ImageConstant.appLogo,
        isRightIcon: false,
        isCommingSoon: true),
  ];

  void _profileMenuNavigate(BuildContext context, int index) {
    switch (index) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        final brightness = theme(context).brightness;
        if (brightness == Brightness.light) {
          return AdaptiveTheme.of(context).setDark();
        } else {
          return AdaptiveTheme.of(context).setLight();
        }

      case 7:
        break;
      case 8:
        Navigator.pushNamed(context, AppRoutes.addPlaceScreen);
        break;
      case 9:
        break;
      case 10:
        break;
      case 11:
        break;
      default:
        Navigator.pushNamed(context, AppRoutes.myProfileScreen);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _profileAppBar(context),
        backgroundColor: Colors.transparent,
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            _userLevel(context),
            SizedBox(height: 10.h),
            _buildMyProfileVoucher(context),
            SizedBox(height: 10.h),
            _buildProfileMenuList(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _profileAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(left: 20.h),
        child: Text(
          context.tr("profile.title", namedArgs: {"name": "User"}),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _userLevel(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 6.h,
      ),
      decoration: CustomDecoration(context).gradientYellowAToOnPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder14,
          ),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              minRadius: 25.h,
              maxRadius: 25.h,
              child: Center(
                child: Icon(Icons.person, size: 50.h),
              ),
            ),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bronze",
                          style: theme(context).textTheme.bodyLarge,
                        ),
                        Icon(Icons.arrow_forward_ios, size: 20.h)
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Level 0",
                      style: theme(context).textTheme.bodySmall,
                    ),
                    Text(
                      "0/10",
                      style: theme(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: 0.6,
                  color: theme(context).colorScheme.onPrimary.withOpacity(0.8),
                  backgroundColor:
                      theme(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(1.h),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyProfileVoucher(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 10.h),
          Flexible(
            child: CustomOutlinedButton(
              height: 40.h,
              text: context.tr(_profileMenuModel[0].label),
              leftIcon: Container(
                margin: EdgeInsets.only(right: 10.h),
                child: Icon(
                  _profileMenuModel[0].icon,
                  size: 18.h,
                  color: theme(context).colorScheme.onPrimaryContainer,
                ),
              ),
              decoration:
                  CustomDecoration(context).gradientYellowAToOnPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
              buttonStyle: CustomButtonStyles.none,
              buttonTextStyle: theme(context).textTheme.bodyMedium,
              onPressed: () => _profileMenuNavigate(context, 0),
            ),
          ),
          SizedBox(width: 10.h),
          Flexible(
            child: CustomOutlinedButton(
              height: 40.h,
              text: context.tr(_profileMenuModel[1].label),
              leftIcon: Container(
                margin: EdgeInsets.only(right: 10.h),
                child: Icon(
                  _profileMenuModel[1].icon,
                  size: 18.h,
                  color: theme(context).colorScheme.onPrimaryContainer,
                ),
              ),
              decoration:
                  CustomDecoration(context).gradientYellowAToOnPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder10,
                      ),
              buttonStyle: CustomButtonStyles.none,
              buttonTextStyle: theme(context).textTheme.bodyMedium,
              onPressed: () => _profileMenuNavigate(context, 1),
            ),
          ),
          SizedBox(width: 10.h),
        ],
      ),
    );
  }

  Widget _buildProfileMenuList() {
    final brightness = theme(context).brightness;
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      decoration:
          CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          _buildProfileMenuListItem(
            context,
            2,
            _profileMenuModel[2].label,
            _profileMenuModel[2].icon,
            _profileMenuModel[2].imageUri,
            _profileMenuModel[2].isRightIcon,
            _profileMenuModel[2].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            3,
            _profileMenuModel[3].label,
            _profileMenuModel[3].icon,
            _profileMenuModel[3].imageUri,
            _profileMenuModel[3].isRightIcon,
            _profileMenuModel[3].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            4,
            _profileMenuModel[4].label,
            _profileMenuModel[4].icon,
            _profileMenuModel[4].imageUri,
            _profileMenuModel[4].isRightIcon,
            _profileMenuModel[4].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            5,
            _profileMenuModel[5].label,
            _profileMenuModel[5].icon,
            _profileMenuModel[5].imageUri,
            _profileMenuModel[5].isRightIcon,
            _profileMenuModel[5].isCommingSoon,
          ), //as
          _buildProfileMenuListItem(
            context,
            6,
            _profileMenuModel[6].label,
            _profileMenuModel[6].icon,
            _profileMenuModel[6].imageUri,
            _profileMenuModel[6].isRightIcon,
            _profileMenuModel[6].isCommingSoon,
            buildRight: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: child.key == const ValueKey("dark")
                      ? Tween<double>(begin: 1, end: 0.75).animate(animation)
                      : Tween<double>(begin: 0.75, end: 1).animate(animation),
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: brightness == Brightness.dark
                  ? Icon(
                      Icons.dark_mode,
                      key: const ValueKey("dark"),
                      size: 20.h,
                    )
                  : Icon(
                      Icons.light_mode,
                      key: const ValueKey("light"),
                      size: 20.h,
                    ),
            ),
          ),
          _buildProfileMenuListItem(
            context,
            7,
            _profileMenuModel[7].label,
            _profileMenuModel[7].icon,
            _profileMenuModel[7].imageUri,
            _profileMenuModel[7].isRightIcon,
            _profileMenuModel[7].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            8,
            _profileMenuModel[8].label,
            _profileMenuModel[8].icon,
            _profileMenuModel[8].imageUri,
            _profileMenuModel[8].isRightIcon,
            _profileMenuModel[8].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            9,
            _profileMenuModel[9].label,
            _profileMenuModel[9].icon,
            _profileMenuModel[9].imageUri,
            _profileMenuModel[9].isRightIcon,
            _profileMenuModel[9].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            10,
            _profileMenuModel[10].label,
            _profileMenuModel[10].icon,
            _profileMenuModel[10].imageUri,
            _profileMenuModel[10].isRightIcon,
            _profileMenuModel[10].isCommingSoon,
          ),
          _buildProfileMenuListItem(
            context,
            11,
            _profileMenuModel[11].label,
            _profileMenuModel[11].icon,
            _profileMenuModel[11].imageUri,
            _profileMenuModel[11].isRightIcon,
            _profileMenuModel[11].isCommingSoon,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuListItem(
    BuildContext context,
    int index,
    String label,
    IconData? icon,
    String? imageUri,
    bool isRightIcon,
    bool isCommingSoon, {
    Widget? buildRight,
  }) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(vertical: 2.5.h),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        leading: icon != null
            ? SizedBox(
                width: 20.h,
                height: 20.h,
                child: Center(
                  child: Icon(
                    icon,
                    size: 20.h,
                  ),
                ),
              )
            : SizedBox(
                width: 20.h,
                height: 20.h,
                child: CustomImageView(
                  imagePath: imageUri ?? "",
                  width: 20.h,
                  height: 20.h,
                  alignment: Alignment.center,
                ),
              ),
        trailing: isRightIcon ? buildRight : const SizedBox(),
        title: Text(
          context.tr(label),
          style: CustomTextStyles(context).bodyMedium_15,
        ),
        onTap: () => _profileMenuNavigate(context, index),
      ),
    );
  }
}
