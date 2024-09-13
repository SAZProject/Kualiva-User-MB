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
    ProfileMenuModel(label: "profile.my_profile", icon: Icons.edit),
    ProfileMenuModel(label: "profile.my_voucher", icon: Icons.card_giftcard),
    ProfileMenuModel(label: "profile.saved", icon: Icons.favorite),
    ProfileMenuModel(label: "profile.my_stats", icon: Icons.bar_chart),
    ProfileMenuModel(label: "profile.my_reviews", icon: Icons.star),
    ProfileMenuModel(label: "profile.notif", icon: Icons.notifications),
    ProfileMenuModel(label: "profile.theme", icon: Icons.brightness_4_outlined),
    ProfileMenuModel(label: "profile.lang", icon: Icons.language),
    ProfileMenuModel(label: "profile.add_place", icon: Icons.add),
    ProfileMenuModel(label: "profile.acc_setting", icon: Icons.lock_person),
    ProfileMenuModel(
        label: "profile.customer_support", icon: Icons.support_agent),
    ProfileMenuModel(
        label: "profile.about_us", imageUri: ImageConstant.appLogo),
  ];

  void _profileMenuNavigate(BuildContext context, int index) {
    switch (index) {
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;
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
      case 12:
        break;
      default:
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
              onPressed: () {},
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
              onPressed: () {},
            ),
          ),
          SizedBox(width: 10.h),
        ],
      ),
    );
  }

  Widget _buildProfileMenuList() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      decoration:
          CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: (_profileMenuModel.length - 2),
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return SizedBox(height: 5.h);
        },
        itemBuilder: (context, index) {
          return _buildProfileMenuListItem(
            context,
            (index + 2),
            _profileMenuModel[(index + 2)].label,
            _profileMenuModel[(index + 2)].icon,
            _profileMenuModel[(index + 2)].imageUri,
          );
        },
      ),
    );
  }

  Widget _buildProfileMenuListItem(
    BuildContext context,
    int index,
    String label,
    IconData? icon,
    String? imageUri,
  ) {
    return SizedBox(
      width: double.maxFinite,
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
        title: Text(
          context.tr(label),
          style: CustomTextStyles(context).bodyMedium_15,
        ),
        onTap: () => _profileMenuNavigate(context, index),
      ),
    );
  }
}
