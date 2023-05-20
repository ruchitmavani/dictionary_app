import 'package:dictionary_app/controllers/search_controller.dart';
import 'package:dictionary_app/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MeaningComponent extends StatelessWidget {
  const MeaningComponent({
    Key? key,
    required this.index,
    required this.search,
  }) : super(key: key);

  final int index;
  final SearchProvider search;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(search.foundModel.meanings.elementAt(index).partOfSpeech.toUpperCase(),
            style: nunitoBold),
        Padding(
          padding: const EdgeInsets.only(left: 16,bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                search.foundModel.meanings.elementAt(index).definitions.length,
                (i) => Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                      "- ${search.foundModel.meanings.elementAt(index).definitions.elementAt(i).definition}"),
                ),),
          ),
        ),
      ],
    );
  }
}
