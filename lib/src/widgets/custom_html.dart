import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomHtml extends StatelessWidget {
  final String data;
  final int? maxLines;
  final EdgeInsets? margin;
  final TextOverflow? textOverflow;

  CustomHtml({
    required this.data,
    this.maxLines,
    this.margin,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data,
      style: {
        "html": Style(
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
        ),
        "body": Style(
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
        ),
        "div": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          padding: EdgeInsets.zero,
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
        ),
        "p": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
          maxLines: maxLines,
          textOverflow: textOverflow,
        ),
        "h6": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(15),
          lineHeight: LineHeight(1.4),
        ),
        "h5": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
        ),
        "h4": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(17),
          lineHeight: LineHeight(1.4),
        ),
        "h3": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(18),
          lineHeight: LineHeight(1.4),
        ),
        "h2": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(19),
          lineHeight: LineHeight(1.4),
        ),
        "h1": Style(
          display: Display.block,
          fontFamily: 'BNazann',
          fontSize: FontSize(20),
          lineHeight: LineHeight(1.4),
        ),
        "span": Style(
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
          maxLines: maxLines,
          textOverflow: textOverflow,
        ),
        "font": Style(
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
        ),
        "ul": Style(
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
        ),
        "ol": Style(
          fontFamily: 'BNazann',
          fontSize: FontSize(16),
        ),
        "table": Style(
          padding: EdgeInsets.zero,
          margin: Margins.zero,
          fontSize: FontSize(16),
          lineHeight: LineHeight(1.4),
          border: Border.all(
            width: 0.6,
          ),
        ),
        "th": Style(
          alignment: Alignment.center,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          padding: EdgeInsets.all(8),
          border: Border.all(
            width: 0.6,
          ),
        ),
        "td": Style(
          alignment: Alignment.center,
          textAlign: TextAlign.center,
          padding: EdgeInsets.all(8),
          border: Border.all(
            width: 0.6,
          ),
        ),
        "a": Style(
          textDecoration: TextDecoration.none,
          fontSize: FontSize(16),
          color: Theme.of(context).primaryColor,
        ),
        "video": Style(
          display: Display.none,
        ),
      },
      onLinkTap: (url, _, __, ___) async {
        if (url != null) {
          await launchUrl(Uri.parse(url));
        }
      },
    );
  }
}
