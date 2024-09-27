import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
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
      children: [
        _buildSelectedNotif(context),
        SizedBox(height: 10.h),
        CustomElevatedButton(
          alignment: Alignment.center,
          leftIcon: Icon(
            Icons.done,
            size: 16.h,
          ),
          initialText: "onboard.onboard_pick_notif_btn_select",
          onPressed: onSelectAll,
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
              itemCount: (listBtnItem.length - 2),
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                if (listBtnItem.isNotEmpty) {
                  return _buildProfileMenuListItem(
                    context,
                    (index + 2),
                    listBtnItem[(index + 2)].label,
                    listBtnItem[(index + 2)].icon,
                    listBtnItem[(index + 2)].imageUri,
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
