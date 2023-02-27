import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utlis/data.dart';
import '../../../../../../core/widgets/custom_drop_down_widget.dart';
import '../../../../../../core/widgets/texts.dart';

class DropCarDetailsWidget extends StatefulWidget {
  final String title;
  final List<dynamic> list;
  final CarBrand? currentValue;
  final Function(dynamic) onSelect;

  DropCarDetailsWidget({required this.title,required this.list,required this.onSelect, required this.currentValue});

  @override
  State<DropCarDetailsWidget> createState() => _DropCarDetailsWidgetState();
}

class _DropCarDetailsWidgetState extends State<DropCarDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color:
                   Colors.grey.withOpacity(.5), width: .5))),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Texts(
                title: widget.title,
                textColor: Color(0xff797979),
                fontSize: 12,
                weight: FontWeight.normal,
                align: TextAlign.start),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomDropDownWidget(
                  currentValue: widget.currentValue,
                  selectCar: false,
                  textColor: Color(0xff28436C),
                  isTwoIcons: false,
                  iconColor: const Color(0xff515151),
                  list: widget.list,
                  onSelect: widget.onSelect,
                  hint: "ملاكى"),
            ),
          )
        ],
      ),
    );
  }
}
