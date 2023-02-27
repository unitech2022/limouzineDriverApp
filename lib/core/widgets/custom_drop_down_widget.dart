import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:limousine_driver/core/utlis/data.dart';

import '../styles/colors.dart';

class CustomDropDownWidget extends StatefulWidget {
  final List<dynamic> list;
  final Function(dynamic) onSelect;
  final String hint;
  final bool isTwoIcons;

  final Color iconColor, textColor;
  final CarBrand? currentValue;
  final bool selectCar;

  const CustomDropDownWidget(
      {this.selectCar = false,
      required this.currentValue,
      required this.textColor,
      required this.iconColor,
      this.isTwoIcons = false,
      required this.list,
      required this.onSelect,
      required this.hint});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  dynamic currentValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        items: widget.list
            .map((item) => DropdownMenuItem<dynamic>(
                value: item,
                child: Text(
                  item.title,
                  style:  TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: widget.textColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                )))
            .toList(),
        value: currentValue,
        onChanged: (v){
          setState(() {
            currentValue = v!;
          });

          widget.onSelect(v!);

        },
        icon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: homeColor,
        ),
        iconSize: 18,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.grey,
        buttonHeight: 50,
        buttonWidth: double.infinity,
        buttonDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
        offset: const Offset(-20, 0),
        hint: Text(
          widget.list[0].title,
          style: const TextStyle(fontFamily: "pnuR", fontSize: 13),
        ),
      ),
    );
  }
}
