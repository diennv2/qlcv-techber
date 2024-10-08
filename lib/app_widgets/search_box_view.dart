import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_rhm/core/languages/keys.dart';
import 'package:mobile_rhm/core/theme/text_theme.dart';
import 'package:mobile_rhm/core/utils/log_utils.dart';
import 'package:mobile_rhm/core/values/assets.dart';
import 'package:mobile_rhm/core/values/colors.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class SearchBoxView extends StatelessWidget {
  TextEditingController? searchController;
  final Function onTextChange;
  final Function? onCompleteChange;
  final Function? onFocusChange;
  final String? hintSearch;
  final String? initSearch;
  final bool? isAutoFocus;
  final bool? isHideIcon;
  final TextInputAction? textInputAction;
  RxBool isShowClear = false.obs;
  String lastQuery = '';
  final String? actionEdit;
  final FocusNode? focusNode;
  final Color? bgColor;
  final EdgeInsetsGeometry? margin;

  SearchBoxView(
      {Key? key,
      required this.onTextChange,
      this.hintSearch,
      this.isAutoFocus,
      this.onCompleteChange,
      this.onFocusChange,
      this.initSearch,
      this.searchController,
      this.isHideIcon,
      this.textInputAction,
      this.actionEdit,
      this.bgColor,
      this.margin,
      this.focusNode})
      : super(key: key) {
    searchController ??= TextEditingController();
    searchController?.text = initSearch ?? '';
    lastQuery = initSearch ?? '';
    searchController?.selection =
        TextSelection(baseOffset: initSearch != null ? initSearch!.length : 0, extentOffset: initSearch != null ? initSearch!.length : 0);
    isShowClear.value = (lastQuery != '' || actionEdit != null);
    LogUtils.log('Init SearchBoxView $initSearch');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 48.h,
      decoration: BoxDecoration(
          color: AppColors.White,
          border: Border.all(color: AppColors.BorderPrimary, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12.w))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 11.w,
          ),
          isHideIcon == true
              ? Container()
              : Image.asset(
                  Assets.ic_search,
                  width: 20.w,
                ),
          isHideIcon == true
              ? Container()
              : SizedBox(
                  width: 11.w,
                ),
          Expanded(
              child: Focus(
            key: Key('SearchView'),
            onFocusChange: (hasFocus) {
              if (onFocusChange != null) {
                onFocusChange!(hasFocus);
              }
            },
            child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: searchController,
                style: AppTextStyle.coolDark15,
                focusNode: focusNode,
                onChanged: (newValue) {
                  onTextChange(newValue);
                  if (actionEdit == null) {
                    if (newValue == '') {
                      isShowClear.value = false;
                    } else {
                      if (!isShowClear.value) {
                        isShowClear.value = true;
                      }
                    }
                  }
                },
                onEditingComplete: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (onCompleteChange != null) {
                    onCompleteChange!(searchController?.text);
                  }
                },
                textInputAction: textInputAction ?? TextInputAction.done,
                autofocus: isAutoFocus ?? false,
                decoration: InputDecoration(
                    hintText: hintSearch ?? AppStrings.search_hint.tr, hintStyle: AppTextStyle.gray15Regular, border: InputBorder.none)),
          )),
          Obx(() {
            return isShowClear.value
                ? TouchableOpacity(
                    onTap: () {
                      if (actionEdit == null) {
                        searchController?.text = '';
                        isShowClear.value = false;
                        onTextChange('');
                      } else {
                        if (focusNode != null) {
                          LogUtils.log('Request focus');
                          focusNode?.requestFocus();
                        }
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        actionEdit ?? Assets.ic_close,
                        width: 20.w,
                      ),
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
