import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../const/appColors.dart';

class DropDownWidget extends StatelessWidget {
  final bool isPhone;
  final String? selectedValue;
  final List items;
  final String hint;
  final void Function(String?)? onChanged;

  const DropDownWidget(
      {super.key,
      this.selectedValue = '',
      this.onChanged,
      this.items = const [],
      this.hint = "Gender",
      this.isPhone = false});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
      isExpanded: true,
      hint: Text('$hint ', style: const TextStyle(color: Colors.white)),
      items: items
          .map((e) => DropdownMenuItem<String>(
              value: '$e',
              child: Text('$e',
                  style: const TextStyle(color: AppColors.textGold))))
          .toList(),
      value: selectedValue.toString().isEmpty ? null : selectedValue,
      onChanged: (String? value) {
        onChanged!(value);
      },
      buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(color: Colors.transparent),
          padding: EdgeInsets.symmetric(horizontal: 5),
          height: 40,
          width: isPhone
              ? (items.first.length > 10 ? w * 0.35 : w * 0.25)
              : (items.first.length > 10 ? w * 0.15 : w * 0.1)),
      dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColors.bgCard2,
        // color: AppColors.silverGold,
      )),
      menuItemStyleData: const MenuItemStyleData(height: 40),
    ));
  }
}
