import 'package:flutter/foundation.dart';

import '../../models/wishlist_item.dart';

class WishlistProvider extends ChangeNotifier {
  List<WishlistItem> _items = [];

  List<WishlistItem> get items => _items;

  void addItem(WishlistItem item) {
    _items.add(item);
    notifyListeners();
  }

  void deleteItem(WishlistItem item) {
    _items.remove(item);
    print('removed');
    notifyListeners();
  }
}
