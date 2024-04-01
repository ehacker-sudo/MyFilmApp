import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemExternalSource extends StatefulWidget {
  final String name;
  final String externalId;
  final String mediaType;

  const ItemExternalSource({
    super.key,
    String? name,
    String? externalId,
    String? mediaType,
  })  : name = name ?? "",
        externalId = externalId ?? "",
        mediaType = mediaType ?? "";

  @override
  State<ItemExternalSource> createState() => _ItemExternalSourceState();
}

class _ItemExternalSourceState extends State<ItemExternalSource> {
  Future<void>? _launched;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    // onPressed calls using this URL are not gated on a 'canLaunch' check
    // because the assumption is that every device can launch a web URL.
    Uri toLaunch = Uri(scheme: 'https', host: 'flutter.dev', path: '/');
    String logo = "";
    if (widget.name == "Imdb") {
      if (widget.mediaType == "person") {
        toLaunch = Uri(
          scheme: 'https',
          host: 'www.imdb.com',
          path: '/name/${widget.externalId}',
        );
      } else {
        toLaunch = Uri(
          scheme: 'https',
          host: 'www.imdb.com',
          path: '/title/${widget.externalId}',
        );
      }

      logo = 'assets/images/imdb.png';
    }
    if (widget.name == "Facebook") {
      toLaunch = Uri(
        scheme: 'https',
        host: 'www.facebook.com',
        path: '/${widget.externalId}',
      );
      logo = 'assets/images/facebook.png';
    }
    if (widget.name == "Wikidata") {
      toLaunch = Uri(
        scheme: 'https',
        host: 'www.wikidata.org',
        path: '/wiki/${widget.externalId}',
      );
      logo = 'assets/images/wikidata.png';
    }
    if (widget.name == "Instagram") {
      toLaunch = Uri(
        scheme: 'https',
        host: 'www.instagram.com',
        path: '/${widget.externalId}',
      );
      logo = 'assets/images/instagram.png';
    }
    if (widget.name == "Twitter") {
      toLaunch = Uri(
        scheme: 'https',
        host: 'twitter.com',
        path: '/${widget.externalId}',
      );
      logo = 'assets/images/twitter.png';
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _launched = _launchInBrowserView(toLaunch);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 15.0,
                right: 10.0,
                bottom: 0,
                top: 0,
              ),
              leading: Image.asset(
                logo,
                width: 40,
              ),
              title: Text(
                widget.name,
                style:
                    const TextStyle(color: MyFilmAppColors.white, fontSize: 20),
              ),
              trailing: Image.asset(
                'assets/images/external_link_outline.png',
                width: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          // FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ],
      ),
    );
  }
}
