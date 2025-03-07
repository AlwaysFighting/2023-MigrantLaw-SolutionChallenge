import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:migrant_law_solutionchallenge/const/color.dart';
import 'package:http/http.dart' as http;

import '../const/api.dart';
import '../service/model/labor_services.dart';

class LaborDetailScreen extends StatefulWidget {
  const LaborDetailScreen({Key? key}) : super(key: key);

  @override
  State<LaborDetailScreen> createState() => _LaborDetailScreenState();
}

class _LaborDetailScreenState extends State<LaborDetailScreen> {
  final subTextStyle = const TextStyle(
      color: SECONDARY_COLOR1, fontSize: 23, fontWeight: FontWeight.w800);

  final mainTextStyle = const TextStyle(
      color: PRIMARY_COLOR, fontSize: 23, fontWeight: FontWeight.w800);

  static String endPointUrl = API().getLaborUrl();
  final Uri url = Uri.parse(endPointUrl);

  late Future<LaborServices> services;

  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  Future<LaborServices> fetchData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return LaborServices.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load Services..");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    services = fetchData();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 1000) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BODY_TEXT_COLOR,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: PRIMARY_COLOR
        ),
        elevation: 0,
        backgroundColor: BODY_TEXT_COLOR,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: PRIMARY_COLOR),
              hintText: 'Search...',
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 0.0, left: 15.0, right: 15.0, bottom: 0.0),
        child: FutureBuilder<LaborServices>(
          future: services,
          builder: (context, snapshot) {
            // 에러 수신 시 에러 메시지 출력
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // 상태처리 인디케이터 표시. 앱 초기에 출력
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    PRIMARY_COLOR,
                  ),
                ),
              );
            }
            return Scrollbar(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 5.0),
                        Text(
                          snapshot.data!.empty.purple.tentacled.cdata,
                          style: subTextStyle,
                        ).translate(),
                        const SizedBox(height: 3.0),
                        Text(
                          "시행일자 : ${snapshot.data!.empty.purple.cunning.text}",
                          style: subTextStyle.copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ).translate(),
                        const SizedBox(height: 5.0),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.empty.indigo.empty.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                const SizedBox(height: 25.0),
                                // const SizedBox(height: 10.0),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    if (snapshot.data?.empty.indigo.empty[index]
                                            .ambitious?.cdata ==
                                        null) ...[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 50.0),
                                        child: Text(
                                            snapshot.data!.empty.indigo
                                                .empty[index].purple.cdata,
                                            style: mainTextStyle.copyWith(
                                                fontSize: 19.0)).translate(),
                                      ),
                                    ] else
                                      ...[
                                        Text(
                                          "제${snapshot.data?.empty.indigo
                                              .empty[index].fluffy.text}조(${snapshot.data?.empty.indigo.empty[index].ambitious?.cdata})",
                                        style: subTextStyle.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0,
                                        ),
                                      ).translate(),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        snapshot.data!.empty.indigo.empty[index]
                                            .purple.cdata,
                                        style: const TextStyle(
                                          color: CupertinoColors
                                              .darkBackgroundGray,
                                          fontSize: 14.0,
                                        ),
                                      ).translate(),
                                      const SizedBox(height: 5.0),
                                      if (snapshot.data!.empty.indigo
                                              .empty[index].magenta !=
                                          null) ...[
                                        for (int i = 0;
                                            i <
                                                snapshot
                                                    .data!
                                                    .empty
                                                    .indigo
                                                    .empty[index]
                                                    .magenta
                                                    .length;
                                            i++) ...[
                                          const SizedBox(height: 4.0),
                                          if (snapshot
                                                  .data!
                                                  .empty
                                                  .indigo
                                                  .empty[index]
                                                  .magenta[i]?["항내용"] !=
                                              null) ...[
                                            Text(snapshot
                                                .data!
                                                .empty
                                                .indigo
                                                .empty[index]
                                                .magenta[i]?["항내용"]["_cdata"].toString() ?? "").translate(),
                                          ],
                                          const SizedBox(height: 4.0),
                                          if (snapshot
                                                  .data!
                                                  .empty
                                                  .indigo
                                                  .empty[index]
                                                  .magenta[i]?["호"] !=
                                              null) ...[
                                            for (int j = 0;
                                                j <
                                                    snapshot
                                                        .data!
                                                        .empty
                                                        .indigo
                                                        .empty[index]
                                                        .magenta[i]?["호"]
                                                        ?.length;
                                                j++) ...[
                                              Text(snapshot
                                                          .data!
                                                          .empty
                                                          .indigo
                                                          .empty[index]
                                                          .magenta[i]?["호"][j]
                                                      ["호내용"]["_cdata"] ??
                                                  "").translate(),
                                              const SizedBox(height: 4.0),
                                            ]
                                          ],
                                        ],
                                      ] else
                                        ...[],
                                      const SizedBox(height: 2.0),
                                      if (snapshot.data!.empty.indigo
                                              .empty[index].cunning?.cdata !=
                                          null) ...[
                                        Text(
                                          "조문 참고 자료 : ${snapshot.data!.empty.indigo.empty[index].cunning?.cdata}",
                                          style: const TextStyle(
                                            color: CupertinoColors
                                                .darkBackgroundGray,
                                            fontSize: 14.0,
                                          ),
                                        ).translate(),
                                      ],
                                    ],
                                  ],
                                )
                              ],
                            );
                          },
                          shrinkWrap: true,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
        onPressed: _scrollToTop,
              backgroundColor: PRIMARY_COLOR.withOpacity(0.9),
              child: const Icon(Icons.arrow_upward, color: BODY_TEXT_COLOR)),
    );
  }
}


