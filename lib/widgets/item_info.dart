import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/constants/theme.dart';

class ItemInfo extends StatefulWidget {
  final String? title;
  final String? releaseDate;
  final String? mediaType;
  const ItemInfo({Key? key, this.title, this.releaseDate, this.mediaType})
      : super(key: key);

  @override
  State<ItemInfo> createState() => _ItemInfoState();
}

class _ItemInfoState extends State<ItemInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${widget.releaseDate?.substring(0, 4)}",
              style: const TextStyle(
                color: MyFilmAppColors.white,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 6.0),
            const Icon(
              Icons.circle,
              size: 3,
              color: MyFilmAppColors.white,
            ),
            const SizedBox(width: 8.0),
            if (widget.mediaType == "tv")
              SvgPicture.asset(
                'assets/images/tv_active.svg',
                width: 13,
              )
            else if (widget.mediaType == "movie")
              SvgPicture.asset(
                'assets/images/tv_active.svg',
                width: 13,
              ),
            const SizedBox(width: 8.0),
            const Icon(
              Icons.circle,
              size: 3,
              color: MyFilmAppColors.white,
            ),
            const SizedBox(width: 8.0),
            if (widget.mediaType == "tv")
              const Text(
                "Tv series",
                style: TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 12,
                ),
              )
            else if (widget.mediaType == "movie")
              const Text(
                "Movie",
                style: TextStyle(
                  color: MyFilmAppColors.white,
                  fontSize: 12,
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 1,
        ),
        Text(
          "${widget.title}",
          style: const TextStyle(
              color: MyFilmAppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
    // return ListTile(
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    //   dense: true,
    //   visualDensity: const VisualDensity(vertical: -3), // to compact
    //   title: SizedBox(
    //     height: 20,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         Text(
    //           "${widget.releaseDate?.substring(0, 4)}",
    //           style: const TextStyle(
    //             color: MyFilmAppColors.white,
    //             fontSize: 15,
    //           ),
    //         ),
    //         const SizedBox(width: 8.0),
    //         const Icon(
    //           Icons.circle,
    //           size: 3,
    //           color: MyFilmAppColors.white,
    //         ),
    //         const SizedBox(width: 8.0),
    //         if (widget.mediaType == "tv")
    //           SvgPicture.asset(
    //             'assets/images/tv_active.svg',
    //             width: 15,
    //           )
    //         else if (widget.mediaType == "movie")
    //           SvgPicture.asset(
    //             'assets/images/tv_active.svg',
    //             width: 15,
    //           ),
    //         const SizedBox(width: 8.0),
    //         const Icon(
    //           Icons.circle,
    //           size: 3,
    //           color: MyFilmAppColors.white,
    //         ),
    //         const SizedBox(width: 8.0),
    //         if (widget.mediaType == "tv")
    //           const Text(
    //             "Tv series",
    //             style: TextStyle(
    //               color: MyFilmAppColors.white,
    //               fontSize: 15,
    //             ),
    //           )
    //         else if (widget.mediaType == "movie")
    //           const Text(
    //             "Movie",
    //             style: TextStyle(
    //               color: MyFilmAppColors.white,
    //               fontSize: 15,
    //             ),
    //           ),
    //       ],
    //     ),
    //   ),
    //   subtitle: Text(
    //     "${widget.title}",
    //     style: const TextStyle(
    //         color: MyFilmAppColors.white,
    //         fontSize: 15,
    //         fontWeight: FontWeight.bold),
    //   ),
    // );
  }
}
