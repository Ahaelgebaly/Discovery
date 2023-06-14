import 'package:equatable/equatable.dart';

class WishlistItem extends Equatable {
  final String name;
  final String locationName;
  final String image;

  WishlistItem({
    required this.name,
    required this.locationName,
    required this.image,
  });

  @override
  List<Object> get props => [name, locationName, image];
}
