import 'package:dictionary_app/utils/color_constants.dart';
import 'package:dictionary_app/utils/decoratio.dart';
import 'package:dictionary_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class BorderedBox extends StatelessWidget {
  final String title;
  final Widget children;

  const BorderedBox({required this.title, required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: borderDecoration,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.5),
              borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(8)),),
            child: Text(title,style: nunitoSemiBold.copyWith(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: children,
          ),
        ],
      ),
    );
  }
}
