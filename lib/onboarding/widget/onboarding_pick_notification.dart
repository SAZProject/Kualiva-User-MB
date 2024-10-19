import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_empty_state.dart';
import 'package:like_it/data/model/ui_model/profile_menu_model.dart';

class OnboardingPickNotification extends StatelessWidget {
  const OnboardingPickNotification({
    super.key,
    required this.listBtnItem,
    required this.selectedIndexes,
    this.onSelectAll,
    required this.onSelected,
  });

  final List<ProfileMenuModel> listBtnItem;
  final Set<int> selectedIndexes;
  final Function()? onSelectAll;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSelectedNotif(context),
        SizedBox(height: 25.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.h),
          child: CustomElevatedButton(
            alignment: Alignment.center,
            leftIcon: Icon(
              Icons.done,
              size: 20.h,
              color: theme(context).colorScheme.onPrimaryContainer,
            ),
            initialText: context.tr("onboard.onboard_pick_notif_btn_select"),
            onPressed: onSelectAll,
            buttonStyle: CustomButtonStyles.none,
            decoration: CustomDecoration(context).outline,
            buttonTextStyle:
                CustomTextStyles(context).titleMediumOnPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedNotif(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      decoration:
          CustomDecoration(context).outlineOnSecondaryContainer.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: listBtnItem.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: listBtnItem.length,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (listBtnItem.isNotEmpty) {
                  return _buildProfileMenuListItem(
                    context,
                    index,
                    listBtnItem[index].label,
                    listBtnItem[index].icon,
                    listBtnItem[index].imageUri,
                  );
                }
                return const CustomEmptyState();
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
        title: Text(
          context.tr(label),
          style: CustomTextStyles(context).bodyMedium_15,
        ),
        onTap: () => onSelected(index),
        selected: selectedIndexes.contains(index),
        selectedTileColor: theme(context).colorScheme.primary,
      ),
    );
  }
}
