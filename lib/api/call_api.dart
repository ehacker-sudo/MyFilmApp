// import 'package:flutter/material.dart';
// import 'package:myfilmapp/api/film_api.dart';
// import 'package:myfilmapp/model/external_id.dart';

// class CallApi<T> extends StatelessWidget {
//   const CallApi({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<ExternalId>(
//       future: TheMovieDbClient().fetchExternalIdResults(
//           "tv/${episode.seriesId}/season/${episode.seasonNumber}/episode/${episode.episodeNumber}/external_ids?api_key=7bb0f209157f0bb4788ecb54be635d14"),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final externalIdFilm = snapshot.data as ExternalId;
//           return SizedBox(
//             height: 50.0 * externalIdFilm.total,
//             child: ListView(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: [
//                 if (externalIdFilm.imdbId != "")
//                   ItemExternalSource(
//                     name: "Imdb",
//                     externalId: externalIdFilm.imdbId,
//                   ),
//                 if (externalIdFilm.facebookId != "")
//                   ItemExternalSource(
//                     name: "Facebook",
//                     externalId: externalIdFilm.facebookId,
//                   ),
//                 if (externalIdFilm.instagramId != "")
//                   ItemExternalSource(
//                     name: "Instagram",
//                     externalId: externalIdFilm.instagramId,
//                   ),
//                 if (externalIdFilm.twitterId != "")
//                   ItemExternalSource(
//                     name: "Twitter",
//                     externalId: externalIdFilm.twitterId,
//                   ),
//                 if (externalIdFilm.wikidataId != "")
//                   ItemExternalSource(
//                     name: "Wikidata",
//                     externalId: externalIdFilm.wikidataId,
//                   ),
//               ],
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Text(
//             '${snapshot.error}',
//             style: const TextStyle(color: MyFilmAppColors.white),
//           );
//         }

//         // By default, show a loading spinner.
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
