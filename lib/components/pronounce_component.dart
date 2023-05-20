import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/controllers/search_controller.dart';
import 'package:dictionary_app/providers.dart';
import 'package:dictionary_app/utils/color_constants.dart';
import 'package:dictionary_app/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_toast/motion_toast.dart';

class PronounceComponent extends ConsumerWidget {
  const PronounceComponent({
    Key? key,
    required this.index,
    required this.search,
    required this.audioPlayer,
  }) : super(key: key);

  final int index;
  final SearchProvider search;
  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 4),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            radius: 10,
            child: Text(
              "${index + 1}",
              style: nunitoRegular.copyWith(
                fontSize: 10,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            backgroundColor: primary.withOpacity(0.3),
          ),
          const SizedBox(
            width: 10,
          ),
          RichText(
            text: TextSpan(
              text: "text: ",
              style: noto.copyWith(fontSize: 12, color: Colors.grey.shade400),
              children: [
                if (search.foundModel.phonetics.elementAt(index).text != null)
                  TextSpan(
                    text: search.foundModel.phonetics.elementAt(index).text!,
                    style: noto.copyWith(fontSize: 16,color:ref.watch(themeProvider).isDark?Colors.white:Colors.black ),
                  )
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 60,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "audio: ",
                  style:
                      noto.copyWith(fontSize: 12, color: Colors.grey.shade700),
                ),
                (search.foundModel.phonetics.elementAt(index).audio != "")
                    ? InkWell(
                        onTap: () async {
                          int result = await audioPlayer.play(search
                              .foundModel.phonetics
                              .elementAt(index)
                              .audio);
                          if (result == 1) {
                            MotionToast.success(
                                    title: const Text("Playing audio"),
                                    description: const Text("audio playing.."),
                                    dismissable: true,
                                    height: 60,
                                    width: 300)
                                .show(context);
                          }
                        },
                        child:
                            const Icon(CupertinoIcons.speaker_2_fill, size: 20),
                      )
                    : const MouseRegion(
                        cursor: SystemMouseCursors.forbidden,
                        child: Icon(
                          CupertinoIcons.speaker_fill,
                          color: Colors.grey,
                          size: 20,
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
