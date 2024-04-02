import 'package:flutter/material.dart';
import 'package:myfilmapp/api/user_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/auth.dart';
import 'package:myfilmapp/model/film.dart';
import 'package:myfilmapp/widgets/bottom_navigation_bar.dart';
import 'package:star_rating/star_rating.dart';

class AddReview extends StatefulWidget {
  static const routeName = '/addReview';
  const AddReview({
    super.key,
  });

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController contentController = TextEditingController();
  double _number = 0.0;
  String content = "";
  late Member args;
  late Future<Member> futureRate;
  late Future<Member> futureComment;

  @override
  void initState() {
    super.initState();
  }

  showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: MyFilmAppColors.submain,
      behavior: SnackBarBehavior.floating,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as Member;
    futureRate = AdminClient().showRateUser(args, _number);
    futureComment = AdminClient().showCommentUser(args, content);
    return Scaffold(
      // backgroundColor: const Color(0xffe5e5e5),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0x33e5e5e5),
                  // Red border with the width is equal to 5
                  border: Border.all(width: 1, color: const Color(0xffe5e5e5))),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FractionallySizedBox(
                      widthFactor: 0.7,
                      alignment: AlignmentDirectional.center,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150 * 0.667,
                                height: 150,
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/w500${args.film.posterPath}${args.episode.stillPath}",
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${args.film.name}${args.film.title}${args.episode.name}",
                                style: const TextStyle(
                                  color: MyFilmAppColors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    width: 30,
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: MyFilmAppColors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    // color: const Color(0xffe5e5e5),
                    padding:
                        const EdgeInsets.only(left: 5, bottom: 10, top: 10),
                    child: const Text(
                      "Đánh giá của bạn",
                      style: TextStyle(
                        color: MyFilmAppColors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: const Color(0xffe5e5e5),
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FutureBuilder<Member>(
                        future: futureRate,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            _number = snapshot.data!.rate;
                          }

                          print("Review Rate: ${snapshot.hasData}");
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StarRating(
                                mainAxisAlignment: MainAxisAlignment.start,
                                length: 10,
                                rating: _number,
                                between: 5,
                                starSize: 20,
                                color: (_number == 0.0)
                                    ? MyFilmAppColors.black
                                    : MyFilmAppColors.submain,
                                onRaitingTap: (rating) {
                                  setState(() {
                                    _number = rating;
                                    futureRate = AdminClient()
                                        .showRateUser(args, _number);
                                  });
                                },
                              ),
                              Text(
                                "${_number.toInt()}",
                                style: const TextStyle(
                                  color: MyFilmAppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  FutureBuilder<Member>(
                      future: futureComment,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          contentController.text = snapshot.data!.content;
                        }
                        return TextFormField(
                          controller: contentController,
                          minLines: 6,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            labelText: 'Viết bình luận của bạn',
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  FutureBuilder<Member>(
                      future: futureComment,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              if (contentController.text != "") {
                                setState(() {
                                  print("Number $_number");
                                  if (_number != 0.0) {
                                    futureRate = AdminClient().rateUpdate(
                                      Member(
                                        film: args.film,
                                        episode: args.episode,
                                        mediaType: args.mediaType,
                                        rate: _number,
                                      ),
                                    );
                                  } else {
                                    futureRate = AdminClient().rateStore(Member(
                                      film: args.film,
                                      episode: args.episode,
                                      mediaType: args.mediaType,
                                      rate: _number,
                                    ));
                                  }

                                  if (snapshot.hasData) {
                                    AdminClient().commentUpdate(Member(
                                      film: args.film,
                                      episode: args.episode,
                                      mediaType: args.mediaType,
                                      content: contentController.text,
                                    ));
                                    showSnackBar("Sửa bình luận thành công");
                                  } else {
                                    AdminClient().commentStore(Member(
                                      film: args.film,
                                      episode: args.episode,
                                      mediaType: args.mediaType,
                                      content: contentController.text,
                                    ));
                                    showSnackBar("Thêm bình luận thành công");
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyFilmAppColors.white,
                              textStyle: const TextStyle(fontSize: 14.0),
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0)),
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              (snapshot.hasData)
                                  ? "Sửa bình luận"
                                  : "Gửi bình luận",
                              style: const TextStyle(
                                color: MyFilmAppColors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
