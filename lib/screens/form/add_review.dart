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
  late double _number = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Film;
    Color rateColor =
        (_number == 0.0) ? MyFilmAppColors.black : MyFilmAppColors.submain;
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
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: 150 * 0.667,
                      height: 150,
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${args.posterPath}",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${args.name}${args.title}",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StarRating(
                          mainAxisAlignment: MainAxisAlignment.start,
                          length: 10,
                          rating: _number,
                          between: 5,
                          starSize: 20,
                          color: rateColor,
                          onRaitingTap: (rating) {
                            setState(() {
                              _number = rating;
                            });
                            // widget.valueChanged(_number);
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
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: contentController,
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      labelText: 'Viết bình luận của bạn',
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        // print(contentController.text);
                        AdminClient().commentStore(Member(
                          film: args,
                          content: contentController.text,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyFilmAppColors.white,
                        textStyle: const TextStyle(fontSize: 14.0),
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Gửi bình luận",
                        style: TextStyle(
                            color: MyFilmAppColors.black, fontSize: 16),
                      ),
                    ),
                  ),
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
