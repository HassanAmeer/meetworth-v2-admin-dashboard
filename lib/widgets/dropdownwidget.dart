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
    var t = Theme.of(context).textTheme;
    return DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
      isExpanded: true,
      hint: Text('$hint ', style: t.labelSmall!.copyWith(color: Colors.white)),
      items: items
          .map((e) => DropdownMenuItem<String>(
              value: '$e',
              child: Text('$e',
                  style: t.labelSmall!.copyWith(color: AppColors.gold))))
          .toList(),
      value: selectedValue.toString().isEmpty ? null : selectedValue,
      onChanged: (String? value) {
        onChanged!(value);
      },
      buttonStyleData: ButtonStyleData(
          decoration: const BoxDecoration(color: Colors.transparent),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          height: 40,
          width: isPhone
              ? (items.first.length > 10 ? w * 0.3 : w * 0.25)
              : (items.first.length > 10 ? w * 0.14 : w * 0.08)),
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
