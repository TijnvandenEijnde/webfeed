import 'package:webfeed/domain/media/category.dart';
import 'package:webfeed/domain/media/content.dart';
import 'package:webfeed/domain/media/credit.dart';
import 'package:webfeed/domain/media/description.dart';
import 'package:webfeed/domain/media/rating.dart';
import 'package:webfeed/domain/media/thumbnail.dart';
import 'package:webfeed/util/iterable.dart';
import 'package:xml/xml.dart';

class Group {
  final List<Content>? contents;
  final List<Credit>? credits;
  final Category? category;
  final Rating? rating;
  final Description? description;
  final List<Thumbnail>? thumbnails;

  Group({
    this.contents,
    this.credits,
    this.category,
    this.rating,
    this.description,
    this.thumbnails
  });

  factory Group.parse(XmlElement element) {
    return Group(
      contents: element
          .findElements('media:content')
          .map((e) => Content.parse(e))
          .toList(),
      credits: element
          .findElements('media:credit')
          .map((e) => Credit.parse(e))
          .toList(),
      category: element
          .findElements('media:category')
          .map((e) => Category.parse(e))
          .firstOrNull,
      rating: element
          .findElements('media:rating')
          .map((e) => Rating.parse(e))
          .firstOrNull,
      description: element
          .findElements('media:description')
          .map((e) => Description.parse(e))
          .firstOrNull,
      thumbnails: element
          .findElements('media:thumbnail')
          .map((e) => Thumbnail.parse(e))
          .toList(),
    );
  }
}
