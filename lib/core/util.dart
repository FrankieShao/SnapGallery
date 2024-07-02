import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/domain/entity/photo/photo.dart';

List<Photo> mergeUniquePhoto(List<Photo> listA, List<Photo> listB) {
  List<Photo> result = List.from(listA);
  result.addAll(listB);
  return result.toSet().toList();
}

List<Collection> mergeUniqueCollection(
    List<Collection> listA, List<Collection> listB) {
  List<Collection> result = List.from(listA);
  result.addAll(listB);
  return result.toSet().toList();
}

String formatNumber(int? n) {
  int number = n ?? 0;
  if (number < 1000) {
    return number.toString();
  } else if (number < 10000) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d+)(\d{3})'), (Match m) => '${m[1]},${m[2]}');
  } else if (number < 1000000) {
    int thousands = number ~/ 1000;
    return '${thousands}k';
  } else if (number < 1000000000) {
    double millions = number / 1000000;
    return '${millions.toStringAsFixed(1)}M';
  } else {
    double billions = number / 1000000000;
    return '${billions.toStringAsFixed(1)}B';
  }
}
