import 'package:flutter/cupertino.dart';

import '../localization/app_localizations.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key);
}
