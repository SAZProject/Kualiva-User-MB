import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';
import 'package:kualiva/profile/widget/notification_checkbox_list.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<String> notifKualivaList = [
    "notif.kualiva_1",
    "notif.kualiva_2",
    "notif.kualiva_3",
  ];
  final List<String> notifWgoList = [
    "notif.wgo_1",
  ];
  final List<String> notifMyVoucherList = [
    "notif.my_voucher_1",
  ];
  final List<String> notifReviewList = [
    "notif.review_1",
  ];
  final List<String> notifCSList = [
    "notif.customer_support_1",
    "notif.customer_support_2",
  ];

  final ValueNotifier<List<List<bool>>> selectedNotif =
      ValueNotifier([[], [], []]);

  final List<bool> selectedKualivaNotif = List.generate(8, (index) => true);
  final List<bool> selectedEmailNotif = List.generate(8, (index) => false);
  final List<bool> selectedWANotif = List.generate(8, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _notificationAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          height: Sizeutils.height,
          child: _body(context),
        ),
      ),
    );
  }

  PreferredSizeWidget _notificationAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("notif.title"),
      onBackPressed: () => Navigator.pop(context),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            _buildNotifHeader(context),
            NotificationCheckboxList(
              header: context.tr("notif.kualiva"),
              itemTresh: 3,
              listNotifSection: notifKualivaList,
              selectedNotif: selectedNotif,
              kualivaNotifVal: selectedKualivaNotif,
              emailNotifVal: selectedEmailNotif,
              whatsappNotifVal: selectedWANotif,
            ),
            SizedBox(height: 5.h),
            NotificationCheckboxList(
              header: context.tr("notif.wgo"),
              itemTresh: 4,
              listNotifSection: notifWgoList,
              selectedNotif: selectedNotif,
              kualivaNotifVal: selectedKualivaNotif,
              emailNotifVal: selectedEmailNotif,
              whatsappNotifVal: selectedWANotif,
            ),
            SizedBox(height: 5.h),
            NotificationCheckboxList(
              header: context.tr("notif.my_voucher"),
              itemTresh: 5,
              listNotifSection: notifMyVoucherList,
              selectedNotif: selectedNotif,
              kualivaNotifVal: selectedKualivaNotif,
              emailNotifVal: selectedEmailNotif,
              whatsappNotifVal: selectedWANotif,
            ),
            SizedBox(height: 5.h),
            NotificationCheckboxList(
              header: context.tr("notif.review"),
              itemTresh: 6,
              listNotifSection: notifReviewList,
              selectedNotif: selectedNotif,
              kualivaNotifVal: selectedKualivaNotif,
              emailNotifVal: selectedEmailNotif,
              whatsappNotifVal: selectedWANotif,
            ),
            SizedBox(height: 5.h),
            NotificationCheckboxList(
              header: context.tr("notif.customer_support"),
              itemTresh: 8,
              listNotifSection: notifCSList,
              selectedNotif: selectedNotif,
              kualivaNotifVal: selectedKualivaNotif,
              emailNotifVal: selectedEmailNotif,
              whatsappNotifVal: selectedWANotif,
            ),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.5.h),
      child: SizedBox(
        width: Sizeutils.width,
        height: 30.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.h),
              child: Text(
                "",
                style: theme(context).textTheme.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              child: CustomImageView(
                imagePath: ImageConstant.appLogo,
                width: 25.h,
                height: 25.h,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              child: Icon(
                Icons.email,
                size: 25.h,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.h),
              child: Icon(
                Icons.phone,
                size: 25.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
