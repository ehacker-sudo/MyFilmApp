import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/widgets/card_credit.dart';
import 'package:myfilmapp/widgets/navbar.dart';
import 'package:myfilmapp/widgets/star_rating_modal.dart';
import 'package:star_rating/star_rating.dart';

import '../../widgets/card_backdrop.dart';

class Episode extends StatefulWidget {
  const Episode({Key? key}) : super(key: key);

  @override
  State<Episode> createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(
        currentPage: "Home",
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(color: MyFilmAppColors.body),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/cuV2O5ZyDLHSOWzg3nLVljp1ubw.jpg",
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyFilmAppColors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: const Text(
                        "3.6",
                        style: TextStyle(
                          color: MyFilmAppColors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      child: const StarRating(
                        mainAxisAlignment: MainAxisAlignment.center,
                        length: 10,
                        rating: 8.0,
                        between: 4,
                        starSize: 25,
                        color: MyFilmAppColors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thời lượng",
                            style: TextStyle(
                              color: MyFilmAppColors.gray,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "113 m",
                            style: TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thời lượng",
                            style: TextStyle(
                              color: MyFilmAppColors.gray,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "113 m",
                            style: TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thời lượng",
                            style: TextStyle(
                              color: MyFilmAppColors.gray,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "113 m",
                            style: TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Thời lượng",
                            style: TextStyle(
                              color: MyFilmAppColors.gray,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "113 m",
                            style: TextStyle(
                              color: MyFilmAppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Giới thiệu phim",
                        style: TextStyle(
                            color: MyFilmAppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A group of pirates lead by Alvida plunder a ship, only to find a barrel which contains a strange boy named Luffy. Luffy is on a mission to find the legendary treasure \"One Piece\" and he befriends the ship's cabin-boy, Coby, who actually wants to become a marine officer. Luffy defeats Alvida and the two journey on in search of crewmates.",
                        style: TextStyle(color: MyFilmAppColors.longText),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Đánh giá phim",
                        style: TextStyle(
                            color: MyFilmAppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return const StarRatingModal();
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.star_border_outlined,
                          color: MyFilmAppColors.submain,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Diễn viên",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return const CardCredit(
                            profilePath: "/4D0PpNI0kmP58hgrwGC3wCjxhnm.jpg",
                            name: "Jennie Kim",
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Tập ảnh",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/original/ncEsesgOJDNrTUED89hYbA117wo.jpg",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Thể loại",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      height: 35,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                              ),
                              child: const Text(
                                "Prison",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Từ khóa",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: AlignmentDirectional.centerStart,
                      height: 35,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                "Prison",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: const Text(
                            "Chi tiết",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            title: const Text(
                              "Mùa phim",
                              style: TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 15),
                            ),
                            subtitle: const Text(
                              "10 mùa",
                              style: TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 10),
                            ),
                            trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_right)),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Đề xuất",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 300,
                      child: Scrollbar(
                        thickness: 1,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return CardBackdrop(
                              width: MediaQuery.of(context).size.width / 1.4,
                              backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
                              title: "True Detective",
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Kênh truyền hình",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      alignment: AlignmentDirectional.centerStart,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            color: MyFilmAppColors.white,
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.all(2),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/original/ayE4LIqoAWotavo7xdvYngwqGML.png",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Công ty sản xuât",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      alignment: AlignmentDirectional.centerStart,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            color: MyFilmAppColors.white,
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.all(2),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/original/ayE4LIqoAWotavo7xdvYngwqGML.png",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                          child: const Text(
                            "Khám giá thêm",
                            style: TextStyle(
                                color: MyFilmAppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/facebook.png',
                              width: 40,
                            ),
                            title: const Text(
                              "Facebook",
                              style: TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 20),
                            ),
                            trailing: Image.asset(
                              'assets/images/external_link_outline.png',
                              width: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/instagram.png',
                              width: 40,
                            ),
                            title: const Text(
                              "Instagram",
                              style: TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 20),
                            ),
                            trailing: Image.asset(
                              'assets/images/external_link_outline.png',
                              width: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/twitter.png',
                              width: 40,
                            ),
                            title: const Text(
                              "Twitter",
                              style: TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 20),
                            ),
                            trailing: Image.asset(
                              'assets/images/external_link_outline.png',
                              width: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/wikidata.png',
                              width: 40,
                            ),
                            title: const Text(
                              "Wikidata",
                              style: TextStyle(
                                  color: MyFilmAppColors.white, fontSize: 20),
                            ),
                            trailing: Image.asset(
                              'assets/images/external_link_outline.png',
                              width: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
