import 'package:meta/meta.dart';

@immutable
abstract class StoriesEvent {}

@immutable
class RequestStories extends StoriesEvent {}
