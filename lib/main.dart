import 'package:audioplayers/audioplayers.dart';
import 'package:dictionary_app/components/bordered_box.dart';
import 'package:dictionary_app/components/meaning_component.dart';
import 'package:dictionary_app/components/pronounce_component.dart';
import 'package:dictionary_app/providers.dart';
import 'package:dictionary_app/utils/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils/text_styles.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Dictionary App',
      theme: ref.watch(themeProvider).isDark
          ? ThemeData(
              primaryColor: primary,
              colorScheme: ColorScheme.dark(primary: primary),
              useMaterial3: true,
            )
          : ThemeData(
              primaryColor: primary,
              colorScheme: ColorScheme.light(primary: primary),
              useMaterial3: true,
            ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _word = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _search() {
    if (_formKey.currentState!.validate()) {
      ref.read(searchProvider).search(_word.text);
    }
  }

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var search = ref.watch(searchProvider);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        cursorColor: primary,
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        controller: _word,
                        autofocus: true,
                        focusNode: _focusNode,
                        style: nunitoSemiBold.copyWith(fontSize: 16),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a word';
                          } else if (value.contains(" ")) {
                            return "please remove space";
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) => _search(),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.only(
                                top: 2, left: 25.0, right: 25.0, bottom: 2),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.2),
                            hintText: "Type your word here",
                            hintStyle: nunitoRegular.copyWith(
                                color: Colors.grey, fontSize: 12),
                            suffixIcon: IconButton(
                              onPressed: _search,
                              icon: const Icon(CupertinoIcons.search),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 15),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ref.read(themeProvider).changeTheme();
                        },
                        icon: ref.watch(themeProvider).isDark
                            ? const Icon(
                                Icons.wb_sunny,
                              )
                            : const Icon(
                                CupertinoIcons.moon_fill,
                              ),
                      ),
                    )
                  ],
                ),
                if (search.isSearched)
                  search.isLoading
                      ? const Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Center(
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                          ),
                        )
                      : (search.isFound)
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Word: ",
                                          style: nunitoSemiBold.copyWith(
                                              color: Colors.grey.shade400),
                                        ),
                                        Text(
                                          "'${search.foundModel.word.toUpperCase()}'",
                                          style: nunitoBold.copyWith(
                                            fontSize: 24,
                                          ),
                                        )
                                      ],
                                    ),
                                    if (search.foundModel.phonetics.isNotEmpty)
                                      BorderedBox(
                                        title: "Pronunciation",
                                        children: ListView.builder(
                                            itemCount: search
                                                .foundModel.phonetics.length,
                                            itemBuilder: (context, index) =>
                                                PronounceComponent(
                                                    search: search,
                                                    audioPlayer: audioPlayer,
                                                    index: index),
                                            shrinkWrap: true),
                                      ),
                                    BorderedBox(
                                      title: "Meanings",
                                      children: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            search.foundModel.meanings.length,
                                        itemBuilder: (context, index) =>
                                            MeaningComponent(
                                                search: search, index: index),
                                      ),
                                    ),
                                    BorderedBox(
                                      title: "Sources",
                                      children: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: search
                                              .foundModel.sourceUrls.length,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: InkWell(
                                                  onTap: () async {
                                                    bool isSuccess =
                                                        await launch.call(search
                                                            .foundModel
                                                            .sourceUrls
                                                            .elementAt(index));
                                                    if (isSuccess) {
                                                      MotionToast.success(
                                                              title: const Text(
                                                                  "Url Launched"),
                                                              description:
                                                                  const Text(
                                                                      "url launching.."),
                                                              dismissable: true,
                                                              height: 60,
                                                              width: 300)
                                                          .show(context);
                                                    } else {
                                                      MotionToast.error(
                                                        description: const Text(
                                                            "url launch failed"),
                                                        height: 30,
                                                        width: 330,
                                                      ).show(context);
                                                    }
                                                  },
                                                  child: Text(
                                                      search.foundModel.sourceUrls.elementAt(index),
                                                      style: TextStyle(
                                                          color: primary)),
                                                ),
                                              )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Lottie.asset(
                                    "assets/notfound.json",
                                    height: 200,
                                  ),
                                  Center(
                                      child: Text(
                                    "Not found in Dictionary",
                                    style:
                                        nunitoSemiBold.copyWith(fontSize: 18),
                                  )),
                                ],
                              ),
                            ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
