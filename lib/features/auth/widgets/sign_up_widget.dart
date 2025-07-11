import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/custom_text_field.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/auth/domain/enum/centralize_login_enum.dart';
import 'package:sixam_mart/features/auth/domain/models/signup_body_model.dart';
import 'package:sixam_mart/features/auth/widgets/auth_dialog_widget.dart';
import 'package:sixam_mart/features/auth/widgets/condition_check_box_widget.dart';
import 'package:sixam_mart/features/auth/widgets/select_location_view_widget.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/verification/screens/verification_screen.dart';
import 'package:sixam_mart/helper/custom_validator.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/helper/validate_check.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  SignUpWidgetState createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _dobFocusNode = FocusNode();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _referCodeFocus = FocusNode();
  final FocusNode _codeFocus = FocusNode();
  final FocusNode _userTypeFocus = FocusNode();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _userTypeController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();
  String? _countryDialCode;
  GlobalKey<FormState>? _formKeySignUp;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _whatsapp_noController = TextEditingController();
  final TextEditingController _whatsapp_no1Controller = TextEditingController();
  final TextEditingController _phone1Controller = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _talukaController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _opens_atController = TextEditingController();
  final TextEditingController _closes_atController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _routeController = TextEditingController();
  final TextEditingController _subrouteController = TextEditingController();
  final TextEditingController _zone_idController = TextEditingController();
  final TextEditingController _gst_noController = TextEditingController();
  final TextEditingController _panCardNoController = TextEditingController();

//   // Image files
  File? _profileImageFile;
  File? _panImageFile;
  File? _shopImageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(
      ImageSource source, Function(File) onImagePicked) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _formKeySignUp = GlobalKey<FormState>();
    _countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel!.country!)
        .dialCode;
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    return Form(
      key: _formKeySignUp,
      child: Container(
        width: context.width > 700 ? 700 : context.width,
        decoration: context.width > 700
            ? BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              )
            : null,
        padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? Dimensions.paddingSizeDefault : 0),
        child: GetBuilder<AuthController>(builder: (authController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            isDesktop
                ? Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.clear)),
                  )
                : const SizedBox(),
            Padding(
              padding: EdgeInsets.all(
                  isDesktop ? Dimensions.paddingSizeExtraLarge : 0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isDesktop
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeLarge),
                            child: Image.asset(Images.logo, width: 125),
                          )
                        : const SizedBox(),
                    isDesktop
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Text('sign_up'.tr,
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge)),
                          )
                        : const SizedBox(),
                    SizedBox(
                        height: isDesktop
                            ? Dimensions.paddingSizeExtraLarge
                            : Dimensions.paddingSizeSmall),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              titleText: 'ex_jhon'.tr,
                              labelText: 'name'.tr,
                              showLabelText: true,
                              required: true,
                              controller: _nameController,
                              focusNode: _nameFocus,
                              nextFocus:
                                  isDesktop ? _referCodeFocus : _phoneFocus,
                              inputType: TextInputType.name,
                              capitalization: TextCapitalization.words,
                              prefixIcon: CupertinoIcons.person_alt_circle_fill,
                              validator: (value) =>
                                  ValidateCheck.validateEmptyText(
                                      value, "please_enter_your_name".tr),
                            ),
                          ),
                          SizedBox(
                              width: Get.find<SplashController>()
                                              .configModel!
                                              .refEarningStatus ==
                                          1 &&
                                      isDesktop
                                  ? Dimensions.paddingSizeSmall
                                  : 0),
                          (Get.find<SplashController>()
                                          .configModel!
                                          .refEarningStatus ==
                                      1 &&
                                  isDesktop)
                              ? Expanded(
                                  child: CustomTextField(
                                    titleText: 'refer_code'.tr,
                                    labelText: 'refer_code'.tr,
                                    showLabelText: true,
                                    controller: _referCodeController,
                                    focusNode: _referCodeFocus,
                                    nextFocus:
                                        isDesktop ? _emailFocus : _phoneFocus,
                                    inputType: TextInputType.text,
                                    capitalization: TextCapitalization.words,
                                    prefixImage: Images.referCode,
                                    divider: false,
                                    prefixSize: 14,
                                  ),
                                )
                              : const SizedBox(),
                        ]),
                    SizedBox(
                        height: isDesktop
                            ? Dimensions.paddingSizeExtraLarge
                            : Dimensions.paddingSizeLarge),
                    Row(children: [
                      isDesktop
                          ? Expanded(
                              child: CustomTextField(
                                titleText: 'enter_email'.tr,
                                labelText: 'email'.tr,
                                showLabelText: true,
                                required: true,
                                controller: _emailController,
                                focusNode: _emailFocus,
                                nextFocus:
                                    isDesktop ? _phoneFocus : _passwordFocus,
                                inputType: TextInputType.emailAddress,
                                prefixIcon: CupertinoIcons.mail_solid,
                                validator: (value) =>
                                    ValidateCheck.validateEmail(value),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                          width: isDesktop ? Dimensions.paddingSizeSmall : 0),
                      Expanded(
                        child: CustomTextField(
                          titleText: 'xxx-xxx-xxxxx'.tr,
                          labelText: 'phone'.tr,
                          showLabelText: true,
                          required: true,
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          nextFocus: isDesktop ? _passwordFocus : _emailFocus,
                          inputType: TextInputType.phone,
                          isPhone: true,
                          onCountryChanged: (CountryCode countryCode) {
                            _countryDialCode = countryCode.dialCode;
                          },
                          countryDialCode: _countryDialCode != null
                              ? CountryCode.fromCountryCode(
                                      Get.find<SplashController>()
                                          .configModel!
                                          .country!)
                                  .code
                              : Get.find<LocalizationController>()
                                  .locale
                                  .countryCode,
                          validator: (value) => ValidateCheck.validateEmptyText(
                              value, "please_enter_phone_number".tr),
                        ),
                      ),
                    ]),
                    SizedBox(
                        height: isDesktop
                            ? Dimensions.paddingSizeExtraLarge
                            : Dimensions.paddingSizeLarge),
                    !isDesktop
                        ? CustomTextField(
                            labelText: 'email'.tr,
                            titleText: 'enter_email'.tr,
                            showLabelText: true,
                            required: true,
                            controller: _emailController,
                            focusNode: _emailFocus,
                            nextFocus: _passwordFocus,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: CupertinoIcons.mail_solid,
                            validator: (value) =>
                                ValidateCheck.validateEmail(value),
                            divider: false,
                          )
                        : const SizedBox(),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'joney'.tr,
                      labelText: 'user_name1'.tr,
                      showLabelText: true,
                      required: true,
                      controller: _userNameController,
                      focusNode: _userNameFocus,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      prefixIcon: CupertinoIcons.person_alt_circle_fill,
                      validator: (value) => ValidateCheck.validateEmptyText(
                          value, "please_enter_your_name".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'Superstockiest'.tr,
                      labelText: 'user_type'.tr,
                      showLabelText: true,
                      required: true,
                      controller: _userTypeController,
                      focusNode: _userTypeFocus,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      prefixIcon: CupertinoIcons.person_alt_circle_fill,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'Code'.tr,
                      labelText: 'enter_code'.tr,
                      showLabelText: true,
                      required: true,
                      controller: _codeController,
                      focusNode: _codeFocus,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),

                      //prefixIcon: CupertinoIcons.person_alt_circle_fill,
                      // validator: (value) => ValidateCheck.validateEmptyText(
                      //     value, "please_enter_your_name".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'whatsApp_number'.tr,
                      labelText: 'WhatsApp Number'.tr,
                      controller: _whatsapp_noController,
                      inputType: TextInputType.phone,
                      prefixIcon: Icons.phone_android,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'alternate_whatsApp_number'.tr,
                      labelText: 'whatsApp_number_2'.tr,
                      controller: _whatsapp_no1Controller,
                      inputType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'alternate_phone'.tr,
                      labelText: 'phone_2'.tr,
                      controller: _phone1Controller,
                      inputType: TextInputType.phone,
                      prefixIcon: Icons.phone,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'landmark'.tr,
                      labelText: 'landmark'.tr,
                      controller: _landmarkController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'area'.tr,
                      labelText: 'area'.tr,
                      controller: _areaController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'taluka'.tr,
                      labelText: 'taluka'.tr,
                      controller: _talukaController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'district'.tr,
                      labelText: 'district'.tr,
                      controller: _districtController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'city'.tr,
                      labelText: 'city'.tr,
                      controller: _cityController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'state'.tr,
                      labelText: 'state'.tr,
                      controller: _stateController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'pincode'.tr,
                      labelText: 'pincode'.tr,
                      controller: _pincodeController,
                      inputType: TextInputType.number,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'date_of_birth'.tr,
                      hintText: 'select_your_dob'.tr,
                      controller: _dobController,
                      focusNode: _dobFocusNode,
                      inputType: TextInputType.none, // disables keyboard
                      inputAction: TextInputAction.next,
                      isEnabled: true,
                      isPassword: false,
                      showTitle: true,
                      showLabelText: true,
                      required: true,
                      // labelText: 'DOB',
                      onTap: () async {
                        //FocusScope.of(context).unfocus(); // hide keyboard
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: Colors.black,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null) {
                          String formattedDate =
                              '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          _dobController.text = formattedDate;
                        }
                      },
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'opens_at'.tr,
                      labelText: 'opens_at'.tr,
                      controller: _opens_atController,
                      prefixIcon: Icons.access_time,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'closes_at'.tr,
                      labelText: 'closes_at'.tr,
                      controller: _closes_atController,
                      prefixIcon: Icons.access_time_filled,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'address'.tr,
                      labelText: 'address'.tr,
                      controller: _addressController,
                      inputType: TextInputType.text,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'latitude'.tr,
                      labelText: 'latitude'.tr,
                      controller: _latitudeController,
                      inputType: TextInputType.number,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    // SelectLocationViewWidget(
                    //   fromView: true,
                    //   mapView: true,
                    //   // mapController: _mapController,
                    //   addressController: _addressController,
                    //   // addressFocus: _addressFocus,
                    //   inDialog: false,
                    //   latitudeController: _latitudeController,
                    //   longitudeController: _longitudeController,
                    // ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'longitude'.tr,
                      labelText: 'longitude'.tr,
                      controller: _longitudeController,
                      inputType: TextInputType.number,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'route'.tr,
                      labelText: 'route'.tr,
                      controller: _routeController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'subroute'.tr,
                      labelText: 'subroute'.tr,
                      controller: _subrouteController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'zone_id'.tr,
                      labelText: 'zone_id'.tr,
                      controller: _zone_idController,
                      inputType: TextInputType.number,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'gst_number'.tr,
                      labelText: 'gst_no.'.tr,
                      controller: _gst_noController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    CustomTextField(
                      titleText: 'pan_card_number'.tr,
                      labelText: 'pan_no.'.tr,
                      controller: _panCardNoController,
                      validator: (value) => ValidateCheck.validateOtherFields(
                          value, "please_enter_required_fields".tr),
                    ),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    const SizedBox(height: 8),
                    Text("upload_documents".tr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _imageTile(
                            "profile_image".tr,
                            _profileImageFile,
                            () => _pickImage(ImageSource.gallery,
                                (file) => _profileImageFile = file)),
                        _imageTile(
                            "pan_card".tr,
                            _panImageFile,
                            () => _pickImage(ImageSource.gallery,
                                (file) => _panImageFile = file)),
                        _imageTile(
                            "shop_image".tr,
                            _shopImageFile,
                            () => _pickImage(ImageSource.gallery,
                                (file) => _shopImageFile = file)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(children: [
                              CustomTextField(
                                titleText: '8+characters'.tr,
                                labelText: 'password'.tr,
                                showLabelText: true,
                                required: true,
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                nextFocus: _confirmPasswordFocus,
                                inputType: TextInputType.visiblePassword,
                                prefixIcon: Icons.lock,
                                isPassword: true,
                                validator: (value) =>
                                    ValidateCheck.validateEmptyText(
                                        value, "please_enter_password".tr),
                              ),
                            ]),
                          ),
                          SizedBox(
                              width:
                                  isDesktop ? Dimensions.paddingSizeSmall : 0),
                          isDesktop
                              ? Expanded(
                                  child: CustomTextField(
                                  titleText: '8+characters'.tr,
                                  labelText: 'confirm_password'.tr,
                                  showLabelText: true,
                                  required: true,
                                  controller: _confirmPasswordController,
                                  focusNode: _confirmPasswordFocus,
                                  nextFocus: Get.find<SplashController>()
                                              .configModel!
                                              .refEarningStatus ==
                                          1
                                      ? _referCodeFocus
                                      : null,
                                  inputAction: Get.find<SplashController>()
                                              .configModel!
                                              .refEarningStatus ==
                                          1
                                      ? TextInputAction.next
                                      : TextInputAction.done,
                                  inputType: TextInputType.visiblePassword,
                                  prefixIcon: Icons.lock,
                                  isPassword: true,
                                  onSubmit: (text) => (GetPlatform.isWeb)
                                      ? _register(
                                          authController, _countryDialCode!)
                                      : null,
                                  validator: (value) =>
                                      ValidateCheck.validateConfirmPassword(
                                          value, _passwordController.text),
                                ))
                              : const SizedBox()
                        ]),
                    SizedBox(
                        height: isDesktop
                            ? Dimensions.paddingSizeExtraLarge
                            : Dimensions.paddingSizeLarge),
                    !isDesktop
                        ? CustomTextField(
                            titleText: '8+characters'.tr,
                            labelText: 'confirm_password'.tr,
                            showLabelText: true,
                            required: true,
                            controller: _confirmPasswordController,
                            focusNode: _confirmPasswordFocus,
                            nextFocus: Get.find<SplashController>()
                                        .configModel!
                                        .refEarningStatus ==
                                    1
                                ? _referCodeFocus
                                : null,
                            inputAction: Get.find<SplashController>()
                                        .configModel!
                                        .refEarningStatus ==
                                    1
                                ? TextInputAction.next
                                : TextInputAction.done,
                            inputType: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            isPassword: true,
                            onSubmit: (text) => (GetPlatform.isWeb)
                                ? _register(authController, _countryDialCode!)
                                : null,
                            validator: (value) =>
                                ValidateCheck.validateConfirmPassword(
                                    value, _passwordController.text),
                          )
                        : const SizedBox(),
                    SizedBox(
                        height: !isDesktop ? Dimensions.paddingSizeLarge : 0),
                    (Get.find<SplashController>()
                                    .configModel!
                                    .refEarningStatus ==
                                1 &&
                            !isDesktop)
                        ? CustomTextField(
                            titleText: 'refer_code'.tr,
                            labelText: 'refer_code'.tr,
                            showLabelText: true,
                            controller: _referCodeController,
                            focusNode: _referCodeFocus,
                            inputAction: TextInputAction.done,
                            inputType: TextInputType.text,
                            capitalization: TextCapitalization.words,
                            prefixImage: Images.referCode,
                            divider: false,
                            prefixSize: 14,
                          )
                        : const SizedBox(),
                    SizedBox(
                        height: isDesktop ? 0 : Dimensions.paddingSizeLarge),
                    const ConditionCheckBoxWidget(forDeliveryMan: true),
                    SizedBox(
                        height: isDesktop
                            ? Dimensions.paddingSizeExtraLarge
                            : Dimensions.paddingSizeDefault),
                    CustomButton(
                      height: isDesktop ? 50 : null,
                      width: isDesktop ? 250 : null,
                      radius: isDesktop
                          ? Dimensions.radiusSmall
                          : Dimensions.radiusDefault,
                      isBold: !isDesktop,
                      fontSize: isDesktop ? Dimensions.fontSizeSmall : null,
                      buttonText: 'sign_up'.tr,
                      isLoading: authController.isLoading,
                      onPressed: authController.acceptTerms
                          ? () => _register(authController, _countryDialCode!)
                          : null,
                    ),
                    SizedBox(
                        height: isDesktop
                            ? Dimensions.paddingSizeExtraLarge
                            : Dimensions.paddingSizeDefault),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeLarge),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('already_have_account'.tr,
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).hintColor)),
                            InkWell(
                              onTap: authController.isLoading
                                  ? null
                                  : () {
                                      if (isDesktop) {
                                        Get.back();
                                        Get.dialog(const Center(
                                            child: AuthDialogWidget(
                                                exitFromApp: false,
                                                backFromThis: false)));
                                      } else {
                                        if (Get.currentRoute ==
                                            RouteHelper.signUp) {
                                          Get.back();
                                        } else {
                                          Get.toNamed(
                                              RouteHelper.getSignInRoute(
                                                  RouteHelper.signUp));
                                        }
                                      }
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeExtraSmall),
                                child: Text('sign_in'.tr,
                                    style: robotoMedium.copyWith(
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ]),
                    ),
                  ]),
            ),
          ]);
        }),
      ),
    );
  }

  void _register(AuthController authController, String countryCode) async {
    SignUpBodyModel? signUpModel = await _prepareSignUpBody(countryCode);

    if (signUpModel == null) {
      return;
    } else {
      authController.registration(signUpModel).then((status) async {
        _handleResponse(status, countryCode);
      });
    }
  }

  void _handleResponse(ResponseModel status, String countryCode) {
    String password = _passwordController.text.trim();
    String numberWithCountryCode = countryCode + _phoneController.text.trim();
    String email = _emailController.text.trim();

    if (status.isSuccess) {
      if (ResponsiveHelper.isDesktop(context)) {
        Get.find<CartController>().getCartDataOnline();
      }
      if (status.authResponseModel != null &&
          !status.authResponseModel!.isPhoneVerified!) {
        List<int> encoded = utf8.encode(password);
        String data = base64Encode(encoded);
        if (Get.find<SplashController>()
            .configModel!
            .firebaseOtpVerification!) {
          Get.find<AuthController>().firebaseVerifyPhoneNumber(
              numberWithCountryCode,
              status.message,
              CentralizeLoginType.manual.name,
              fromSignUp: true);
        } else {
          if (ResponsiveHelper.isDesktop(context)) {
            Get.back();
            Get.dialog(VerificationScreen(
              number: numberWithCountryCode,
              email: null,
              token: status.message,
              fromSignUp: true,
              fromForgetPassword: false,
              loginType: CentralizeLoginType.manual.name,
              password: password,
            ));
          } else {
            Get.toNamed(RouteHelper.getVerificationRoute(
              numberWithCountryCode,
              null,
              status.message,
              RouteHelper.signUp,
              data,
              CentralizeLoginType.manual.name,
            ));
          }
        }
      } else if (status.authResponseModel != null &&
          !status.authResponseModel!.isEmailVerified!) {
        List<int> encoded = utf8.encode(password);
        String data = base64Encode(encoded);
        if (ResponsiveHelper.isDesktop(context)) {
          Get.back();
          Get.dialog(VerificationScreen(
            number: null,
            email: email,
            token: status.message,
            fromSignUp: true,
            fromForgetPassword: false,
            loginType: CentralizeLoginType.manual.name,
            password: password,
          ));
        } else {
          Get.toNamed(RouteHelper.getVerificationRoute(
            null,
            email,
            status.message,
            RouteHelper.signUp,
            data,
            CentralizeLoginType.manual.name,
          ));
        }
      } else {
        Get.find<ProfileController>().getUserInfo();
        Get.find<LocationController>()
            .navigateToLocationScreen(RouteHelper.signUp);
        if (ResponsiveHelper.isDesktop(context)) {
          Get.back();
        }
      }
    } else {
      showCustomSnackBar(status.message);
    }
  }

  Widget _imageTile(String label, File? file, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(),
          image: file != null
              ? DecorationImage(image: FileImage(file), fit: BoxFit.cover)
              : null,
        ),
        child: file == null
            ? Center(child: Text(label, textAlign: TextAlign.center))
            : null,
      ),
    );
  }

  Future<SignUpBodyModel?> _prepareSignUpBody(String countryCode) async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String number = _phoneController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();
    String referCode = _referCodeController.text.trim();

    String numberWithCountryCode = countryCode + number;
    PhoneValid phoneValid =
        await CustomValidator.isPhoneValid(numberWithCountryCode);
    numberWithCountryCode = phoneValid.phone;

    if (_formKeySignUp!.currentState!.validate()) {
      if (name.isEmpty) {
        showCustomSnackBar('please_enter_your_name'.tr);
      } else if (email.isEmpty) {
        showCustomSnackBar('enter_email_address'.tr);
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar('enter_a_valid_email_address'.tr);
      } else if (number.isEmpty) {
        showCustomSnackBar('enter_phone_number'.tr);
      } else if (!phoneValid.isValid) {
        showCustomSnackBar('invalid_phone_number'.tr);
      } else if (password.isEmpty) {
        showCustomSnackBar('enter_password'.tr);
      } else if (password.length < 8) {
        showCustomSnackBar('password_should_be_8_characters'.tr);
      } else if (password != confirmPassword) {
        showCustomSnackBar('confirm_password_does_not_matched'.tr);
      } else if (referCode.isNotEmpty && referCode.length != 10) {
        showCustomSnackBar('invalid_refer_code'.tr);
      } else {
        SignUpBodyModel signUpBody = SignUpBodyModel(
          name: name,
          email: email,
          phone: numberWithCountryCode,
          password: password,
          code: referCode,
          landmark: _landmarkController.text.trim(),
          area: _areaController.text.trim(),
          taluka: _talukaController.text.trim(),
          district: _districtController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          pincode: _pincodeController.text.trim(),
          opensAt: _opens_atController.text.trim(),
          closesAt: _closes_atController.text.trim(),
          route: _routeController.text.trim(),
          subroute: _subrouteController.text.trim(),
          latitude: _latitudeController.text.trim(),
          longitude: _longitudeController.text.trim(),
          zoneId: _zone_idController.text.trim(),
          address: _addressController.text.trim(),
          username: _userNameController.text.trim(),

          // Owner Info

          dob: _dobController.text.trim(),
          phone1: _phone1Controller.text.trim(),
          whatsappNo: _whatsapp_noController.text.trim(),
          whatsappNo1: _whatsapp_no1Controller.text.trim(),
          panNo: _panCardNoController.text.trim(),
          gstNo: _gst_noController.text.trim(),
          usertype: _userTypeController.text.trim(),

          // Base64 Images (if needed)
          // image: _profileImageFile,
          // panCard: _panImageFile,
          //udyamCard = _panImageFile,
        );
        return signUpBody;
      }
    }
    return null;
  }
}
