import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:like_it/common/app_export.dart';
import 'package:like_it/common/style/custom_btn_style.dart';
import 'package:like_it/common/utility/datetime_utils.dart';
import 'package:like_it/common/widget/custom_checkbox_button.dart';
import 'package:like_it/common/widget/custom_drop_down.dart';
import 'package:like_it/common/widget/custom_elevated_button.dart';
import 'package:like_it/common/widget/custom_section_header.dart';
import 'package:like_it/common/widget/custom_text_form_field.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _listType = [
    "F&B",
    "Hostelry",
    "Groceries",
    "Lounge",
    "Spa",
    "Mall",
    "Recreation",
  ];
  final List<String> _listTags = [
    "Beverages",
    "All You Can Eat",
    "Chinese Dish",
    "Japanese Dish",
    "Indian Dish",
    "Seafood",
    "Dine In",
    "Buffet",
    "Vegetarian",
    "Cafe",
    "Cocktail",
    "Coffee",
    "Tea",
    "European Dish",
    "Asian Dish",
    "Fast Food",
    "Drive Thru",
    "Takeaway",
    "Italian Food",
    "Local Food",
    "Warteg",
  ];
  List<bool> selectedDay = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  // Personal data
  TextEditingController personalFullNameCtl = TextEditingController();
  TextEditingController personalCurrentLocation = TextEditingController();
  String? latitude;
  String? longitude;

  //Place Data
  TextEditingController placeFullNameCtl = TextEditingController();
  String? placeType;
  TextEditingController placeContactCtl = TextEditingController();
  List<String>? placePermitImages;
  List<String>? placeTags;
  TextEditingController placeAddressgeneralCtl = TextEditingController();
  TextEditingController placeAddressDetailCtl = TextEditingController();
  List<int> listOperationalDay = List.generate(7, (index) => index);
  List<DateTime> listOperationalTimeOpen =
      List.generate(7, (index) => DateTime(0, 0, 0, 0, 0));
  List<DateTime> listOperationalTimeClose =
      List.generate(7, (index) => DateTime(0, 0, 0, 0, 0));
  List<String>? placeImages;
  List<String>? placeMenuImages;

  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: Sizeutils.height,
          decoration: BoxDecoration(
            color: theme(context)
                .colorScheme
                .onSecondaryContainer
                .withOpacity(0.6),
            image: DecorationImage(
              image: AssetImage(ImageConstant.background2),
              fit: BoxFit.cover,
            ),
          ),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _addPlaceAppBar(context),
          ];
        },
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _buildPersonalData(context),
                SizedBox(height: 10.h),
                _buildPlaceData(context),
                SizedBox(height: 10.h),
                _buildAgreedTosPolicy(context),
                SizedBox(height: 10.h),
                _submitBtn(context),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _addPlaceAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: 55.h,
      leadingWidth: 50.h,
      titleSpacing: 0.0,
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(10.h),
        child: IconButton(
          iconSize: 40.h,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Text(
          context.tr("add_place.title"),
          style: theme(context).textTheme.headlineSmall,
        ),
      ),
    );
  }

  Widget _buildPersonalData(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("add_place.personal"),
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          _buildTextFormComponent(
            context,
            context.tr("add_place.full_name"),
            personalFullNameCtl,
            context.tr("add_place.full_name"),
            "50",
          ),
          SizedBox(height: 4.h),
          //TODO get location open google map
          _buildLocationComponent(
            context,
            context.tr("add_place.location"),
            personalCurrentLocation,
            context.tr("add_place.loc_hint"),
            () {},
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildPlaceData(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 5.h),
      decoration:
          CustomDecoration(context).fillOnSecondaryContainer_03.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder10,
              ),
      child: Column(
        children: [
          CustomSectionHeader(
            label: context.tr("add_place.place"),
            useIcon: false,
          ),
          SizedBox(height: 4.h),
          _buildTextFormComponent(
            context,
            context.tr("add_place.place_name"),
            placeFullNameCtl,
            context.tr("add_place.place_name"),
            "50",
          ),
          SizedBox(height: 4.h),
          _buildDropDownComponent(
            context,
            context.tr("add_place.type"),
            _listType,
            context.tr("add_place.type_hint"),
            (value) {},
          ),
          SizedBox(height: 4.h),
          //TODO pick image by gallery or camera
          _buildAttachMedia(
            context,
            context.tr("add_place.licence_permit"),
          ),
          SizedBox(height: 4.h),
          _buildDropDownComponent(
            context,
            context.tr("add_place.tags"),
            _listTags,
            context.tr("add_place.tags_hint"),
            (value) {},
          ),
          SizedBox(height: 4.h),
          _buildTextFormComponent(
            context,
            context.tr("add_place.contact"),
            placeContactCtl,
            context.tr("add_place.contact_hint"),
            "15",
          ),
          SizedBox(height: 4.h),
          _buildLocationComponent(
            context,
            context.tr("add_place.address"),
            placeAddressgeneralCtl,
            context.tr("add_place.address_general"),
            () {},
          ),
          SizedBox(height: 4.h),
          _buildTextFormComponent(
            context,
            context.tr("add_place.address_detail"),
            placeAddressDetailCtl,
            context.tr("add_place.address_detail"),
            "200",
          ),
          SizedBox(height: 4.h),
          //TODO add Time picker for open and close
          _buildOperationalDaynTime(context),
          SizedBox(height: 4.h),
          //TODO pick image by gallery or camera
          _buildAttachMedia(
            context,
            context.tr("add_place.place_picture"),
            hasrule: true,
            ruleContent: context.tr("add_place.place_picture_rule"),
          ),
          SizedBox(height: 4.h),
          //TODO pick image by gallery or camera
          _buildAttachMedia(
            context,
            context.tr("add_place.place_menu_picture"),
            hasrule: true,
            ruleContent: context.tr("add_place.place_menu_rule"),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  Widget _buildTextFormComponent(
    BuildContext context,
    String headerLabel,
    TextEditingController controller,
    String hintText,
    String maxWord,
  ) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerLabel,
            textAlign: TextAlign.center,
            style: theme(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          CustomTextFormField(
            controller: controller,
            hintText: hintText,
            textInputAction: TextInputAction.done,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 14.h,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${controller.value.text.length}/$headerLabel",
              textAlign: TextAlign.center,
              style: theme(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationComponent(
    BuildContext context,
    String headerLabel,
    TextEditingController controller,
    String hintText,
    void Function()? onPressed,
  ) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerLabel,
            textAlign: TextAlign.center,
            style: theme(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          CustomTextFormField(
            controller: controller,
            hintText: hintText,
            textInputAction: TextInputAction.done,
            readOnly: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 14.h,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildDropDownComponent(
    BuildContext context,
    String headerLabel,
    List<String> items,
    String hintText,
    Function(String)? onChange,
  ) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerLabel,
            textAlign: TextAlign.center,
            style: theme(context).textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),
          CustomDropDown(
            icon: Container(
              margin: EdgeInsets.only(left: 16.h),
              child: Icon(
                Icons.arrow_drop_down,
                size: 26.h,
              ),
            ),
            iconSize: 26.h,
            hintText: hintText,
            items: items,
            contentPadding: EdgeInsets.all(10.h),
            onChange: onChange,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachMedia(BuildContext context, String headerLabel,
      {bool hasrule = false, String ruleContent = ""}) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerLabel,
            textAlign: TextAlign.center,
            style: theme(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 22.h),
            decoration:
                CustomDecoration(context).fillOnSecondaryContainer.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder10,
                    ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_file,
                  size: 16.h,
                ),
                SizedBox(height: 4.h),
                Text(
                  context.tr("add_place.attach_media_content"),
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  context.tr("add_place.max_media"),
                  textAlign: TextAlign.center,
                  style: theme(context).textTheme.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          hasrule
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    ruleContent,
                    textAlign: TextAlign.center,
                    style: theme(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Container(),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildOperationalDaynTime(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ExpansionTile(
        title: Text(
          context.tr("f_n_b_detail.about_open"),
          style: CustomTextStyles(context).bodySmall12,
        ),
        children: listOperationalDay
            .map((index) => _operationalDayHourView(context, index))
            .toList(),
      ),
    );
  }

  Widget _operationalDayHourView(BuildContext context, int index) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          SizedBox(
            height: 14.h,
            width: 14.h,
            child: Checkbox(
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              value: selectedDay[index],
              checkColor: theme(context).colorScheme.primary,
              onChanged: (value) {
                selectedDay[index] = value!;
              },
            ),
          ),
          Text(
            DatetimeUtils.getDays(index),
            style: CustomTextStyles(context).bodySmall12,
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 14.h,
              width: 14.h,
              child: Text(
                DatetimeUtils.getHour(listOperationalTimeOpen[index]),
                style: CustomTextStyles(context).bodySmall12,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: SizedBox(
              height: 14.h,
              width: 14.h,
              child: Text(
                DatetimeUtils.getHour(listOperationalTimeClose[index]),
                style: CustomTextStyles(context).bodySmall12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreedTosPolicy(BuildContext context) {
    return CustomCheckboxButton(
      isRichtext: true,
      value: isAgreed,
      richTextWidget: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: [
            TextSpan(
              text: context.tr("add_place.agreement"),
              style: CustomTextStyles(context).bodySmallOnPrimaryContainer,
            ),
            TextSpan(
              text: context.tr("add_place.tos"),
              style: theme(context).textTheme.labelMedium!.copyWith(
                    color: appTheme.yellowA700,
                    decorationColor: appTheme.yellowA700,
                    decoration: TextDecoration.underline,
                  ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
              text: context.tr("add_place.and"),
              style: CustomTextStyles(context).bodySmallOnPrimaryContainer,
            ),
            TextSpan(
              text: context.tr("add_place.policy"),
              style: theme(context).textTheme.labelMedium!.copyWith(
                    color: appTheme.yellowA700,
                    decorationColor: appTheme.yellowA700,
                    decoration: TextDecoration.underline,
                  ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
      onPressed: () {
        setState(() {
          isAgreed = !isAgreed;
        });
      },
      onChange: (value) {
        isAgreed = value;
      },
    );
  }

  Widget _submitBtn(BuildContext context) {
    return CustomElevatedButton(
      initialText: context.tr("add_place.submit_btn"),
      buttonStyle: CustomButtonStyles.none,
      decoration:
          CustomButtonStyles.gradientYellowAToPrimaryL10Decoration(context),
      buttonTextStyle: CustomTextStyles(context).titleMediumOnPrimaryContainer,
      onPressed: () {},
    );
  }
}
