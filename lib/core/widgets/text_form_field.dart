import 'package:flutter/material.dart';

import '../styles/colors.dart';


class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final void Function() onTap;
  final TextInputType inputType;
  const TextFormFieldWidget({
    super.key,
    required this.fieldName,
    required this.myController,
    required this.myIcon,
    required this.prefixIconColor,
    required this.onTap
    ,required this.inputType
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextFormField(
        controller: myController,
        keyboardType: inputType,
        style: const TextStyle(color:textColor3 ),
        cursorColor: Colors.grey,
        enabled: true,
        decoration: InputDecoration(
          
            hintStyle: const TextStyle(color: Colors.grey),
            labelText: fieldName,
            
            suffixIcon: InkWell(
              onTap: onTap,
              child: Icon(myIcon, color: const Color(0xffA5A5A5),size: 18,)),
            border:  OutlineInputBorder(
               borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xffDBDBDB)),
            ),
            labelStyle: const TextStyle(color: Color(0xffDBDBDB))),
      ),
    );
  }
}
