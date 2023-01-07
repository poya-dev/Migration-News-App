import 'package:equatable/equatable.dart';

enum Language { english, persian, pashto }

abstract class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object> get props => [];
}

class LocaleChanged extends LocaleEvent {
  final Language lang;
  const LocaleChanged({required this.lang});

  @override
  List<Object> get props => [lang];
}
