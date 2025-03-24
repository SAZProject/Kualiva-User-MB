import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/screen/widget/notification_item.dart';
import 'package:kualiva/common/utility/datetime_utils.dart';
import 'package:kualiva/common/widget/custom_app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> listNotif = [];

  @override
  void initState() {
    super.initState();
    listNotif = List.generate(
      20,
      (index) => {
        "title": Faker().guid.guid(),
        "content": Faker().lorem.sentence(),
        "publishDate": DatetimeUtils.dmy(
          Faker().date.dateTime(minYear: 2024, maxYear: 2025),
        ),
        "isExpanded": false,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _notificationAppBar(context),
        body: _body(context),
      ),
    );
  }

  PreferredSizeWidget _notificationAppBar(BuildContext context) {
    return CustomAppBar(
      title: context.tr("notif.title"),
      onBackPressed: () => Navigator.pop(context),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 5.h),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              size: 25.h,
            ),
            onPressed: () => Navigator.pushNamed(
                context, AppRoutes.notificationSettingScreen),
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: Sizeutils.height,
      child: _buildNotificationList(context),
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return listNotif.isEmpty
        ? SizedBox.shrink()
        : ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemExtent: 80.h,
            itemCount: listNotif.length,
            itemBuilder: (context, index) {
              return NotificationListItem(
                index: index,
                title: listNotif[index]["title"],
                content: listNotif[index]["content"],
                publishDate: listNotif[index]["publishDate"],
                isExpanded: listNotif[index]["isExpanded"],
                onPressed: () {},
                onDelete: () => setState(() => listNotif.removeAt(index)),
                confirmDismiss: (direction) {
                  setState(() => listNotif[index]["isExpanded"] =
                      !listNotif[index]["isExpanded"]);
                  return Future.value();
                },
              );
            },
          );
  }
}
