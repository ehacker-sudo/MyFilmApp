import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/season/tv_season.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetail extends StatefulWidget {
  final String name;
  final String content;
  final Function() onTap;
  const ItemDetail({
    super.key,
    String? name,
    String? content,
    Function()? onTap,
  })  : name = name ?? "",
        content = content ?? "",
        onTap = onTap ?? defaultOnTap;

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
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
    Uri toLaunch = Uri.parse(widget.content);
    return InkWell(
      onTap: widget.onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          contentPadding: const EdgeInsets.only(
            left: 15.0,
            right: 0,
            bottom: 0,
            top: 0,
          ),
          title: Text(
            widget.name,
            style: const TextStyle(color: MyFilmAppColors.white, fontSize: 15),
          ),
          subtitle: (widget.name != "Trang chủ chính")
              ? Text(
                  widget.content,
                  style: const TextStyle(
                      color: MyFilmAppColors.white, fontSize: 10),
                )
              : null,
          trailing: (widget.name == "Trang chủ chính")
              ? IconButton(
                  onPressed: () {
                    setState(
                      () {
                        _launched = _launchInBrowserView(toLaunch);
                      },
                    );
                  },
                  icon: const Icon(Icons.arrow_right),
                )
              : (widget.onTap != defaultOnTap)
                  ? IconButton(
                      onPressed: widget.onTap,
                      icon: const Icon(Icons.arrow_right),
                    )
                  : null,
        ),
      ),
    );
  }
}

Function defaultOnTap() {
  return () {
    print("On Tap");
  };
}
