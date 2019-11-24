import 'package:meta/meta.dart';

@immutable
abstract class Item {
  
  final int id;
  final String author;
  final DateTime createdAt;

  Item({
    @required this.id,
    @required this.author,
    @required timestamp,
  })
    : createdAt = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

}
