import 'package:flutter/material.dart';
import 'package:kualiva/common/app_export.dart';
import 'package:kualiva/common/utility/sized_utils.dart';
import 'package:kualiva/common/widget/custom_section_header.dart';
import 'package:kualiva/profile/widget/notification_checkbox_item.dart';

class NotificationCheckboxList extends StatelessWidget {
  const NotificationCheckboxList({
    super.key,
    required this.header,
    required this.itemTresh,
    required this.listNotifSection,
    required this.kualivaNotifVal,
    required this.emailNotifVal,
    required this.whatsappNotifVal,
    required this.selectedNotif,
  });

  final String header;
  final int itemTresh;
  final List<String> listNotifSection;
  final List<bool> kualivaNotifVal;
  final List<bool> emailNotifVal;
  final List<bool> whatsappNotifVal;
  final ValueNotifier<List<List<bool>>> selectedNotif;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSectionHeader(
            label: header,
            useIcon: false,
            textStyle: CustomTextStyles(context).bodySmall12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: SizedBox(
              width: double.maxFinite,
              child: ValueListenableBuilder(
                valueListenable: selectedNotif,
                builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: listNotifSection.length,
                    itemBuilder: (context, index) {
                      //TODO add waiting, empty, error state in future
                      return NotificationCheckboxItem(
                        label: listNotifSection[index],
                        kualivaNotifVal:
                            kualivaNotifVal[indexAlgo(itemTresh, index)],
                        emailNotifVal:
                            emailNotifVal[indexAlgo(itemTresh, index)],
                        whatsappNotifVal:
                            whatsappNotifVal[indexAlgo(itemTresh, index)],
                        kualivaNotifOnChange: (value) {
                          kualivaNotifVal[indexAlgo(itemTresh, index)] = value;
                          selectedNotif.value = [
                            kualivaNotifVal,
                            emailNotifVal,
                            whatsappNotifVal
                          ];
                        },
                        emailNotifOnChange: (value) {
                          debugPrint("1 : $emailNotifVal");
                          emailNotifVal[indexAlgo(itemTresh, index)] = value;
                          debugPrint("2 : $emailNotifVal");
                          selectedNotif.value = [
                            kualivaNotifVal,
                            emailNotifVal,
                            whatsappNotifVal
                          ];
                        },
                        whatsappNotifOnChange: (value) {
                          whatsappNotifVal[indexAlgo(itemTresh, index)] = value;
                          selectedNotif.value = [
                            kualivaNotifVal,
                            emailNotifVal,
                            whatsappNotifVal
                          ];
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  int indexAlgo(int itemTresh, int index) {
    switch (itemTresh) {
      case 3:
        return index;
      case 4:
      case 5:
      case 6:
        return itemTresh - 1;
      case 8:
        if (index == 0) return (itemTresh - 2);
        return itemTresh - 1;
    }
    return 0;
  }
}
