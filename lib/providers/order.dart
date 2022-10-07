import 'package:flutter/material.dart';

class CartItems {
  String? id;
  String? price;
  String? discountOnPrice;
  String? title;
  String? reviews;
  String? image;
  String? qty;
  String? priceAfterDiscount;
  String? reviewsCount;
  String? path;
  String? purchasedDate;
  String? merchantId;

  CartItems({
    this.id,
    this.merchantId,
    this.purchasedDate,
    this.reviewsCount,
    this.priceAfterDiscount,
    this.qty,
    this.price,
    this.discountOnPrice,
    this.reviews,
    this.title,
    this.image,
    this.path,
  });
}

class Cart with ChangeNotifier {
  final List<CartItems> _cartItemsList = [];
  int _qty = 0;
  Map<String, CartItems> _cartMap = {};

  List<CartItems> get cartItems => _cartItemsList;
  Map<String, CartItems> get cartMap => {..._cartMap};
  int get qty => _qty;

  addTCart({
    required String? id,
    required String? price,
    required String? title,
    required String? image,
    required String? reviews,
    required String? discountOnPrice,
    required String? path,
    required String? merchantId,
    String? afterDiscount = '0',
    String? reviewsCount = '0',
    bool isWishList = false,
  }) {
    print('id : $id');

    if (_cartMap.containsKey(id)) {
      _cartMap.update(
          id!,
          (cartItem) => CartItems(
                reviewsCount: cartItem.reviewsCount,
                priceAfterDiscount: cartItem.priceAfterDiscount,
                qty: '${int.parse(cartItem.qty!) + 1}',
                id: cartItem.id,
                path: cartItem.path ?? '',
                image: cartItem.image ?? '',
                price: cartItem.price,
                reviews: cartItem.reviews ?? '0',
                discountOnPrice: cartItem.discountOnPrice,
                title: cartItem.title!,
                merchantId: merchantId,
              ));
    } else {
      print('id : $id');
      _cartMap.putIfAbsent(
        id!,
        () => CartItems(
          reviewsCount: reviewsCount ?? '0',
          priceAfterDiscount: calculateDiscount(discountOnPrice!, price!),
          qty: isWishList == true ? '1' : '$qty',
          id: id,
          path: path!,
          image: image ?? '',
          price: price,
          reviews: reviews ?? '0',
          discountOnPrice: discountOnPrice,
          title: title!,
          merchantId: merchantId,
        ),
      );
      print(cartMap[id]!.title ?? 'null values');
    }
    // _cartItemsList.add(
    //   CartItems(
    //     reviewsCount: reviewsCount ?? '0',
    //     priceAfterDiscount: calculateDiscount(discountOnPrice!, price!),
    //     qty: qty.toString(),
    //     id: id!,
    //     path: path!,
    //     image: image ?? '',
    //     price: price,
    //     reviews: reviews ?? '0',
    //     discountOnPrice: discountOnPrice,
    //     title: title!,
    //   ),
    // );
    notifyListeners();
  }

  //remove deal from the cart
  void removeItem(String dealId) {
    _cartMap.remove(dealId);
    notifyListeners();
  }

  void checkIsAddedToCart(BuildContext context) {
    if (cartMap.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('deal added to the cart'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('error while adding to cart'),
        ),
      );
    }
  }

  // void removeItem(String productId) {
  //   _items.remove(productId);
  //   notifyListeners();
  // }

  void removeSingleItem(String productId) {
    if (int.parse(_cartMap[productId]!.qty!) > 1) {
      _cartMap.update(
          productId,
          (existingCartItem) => CartItems(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                qty: '${int.parse(existingCartItem.qty!) - 1}',
                reviewsCount: existingCartItem.reviewsCount ?? '0',
                priceAfterDiscount: existingCartItem.priceAfterDiscount,
                path: existingCartItem.path,
                image: existingCartItem.image,
                reviews: existingCartItem.reviews,
                discountOnPrice: existingCartItem.discountOnPrice,
              ));
    } else {
      _cartMap.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartMap = {};
    notifyListeners();
  }

  void increaseQty() {
    _qty += 1;

    notifyListeners();
  }

  void decreaseQty() {
    _qty -= 1;
    if (_qty <= 0) _qty = 0;
    debugPrint(qty.toString());
    notifyListeners();
  }

  String calculateDiscount(
    String discountOnPrice,
    String price,
  ) {
    double? priceAfterDiscount = 0;
    double? getPrice;
    double? percentage;
    percentage = int.parse(discountOnPrice) / 100;
    getPrice = percentage * int.parse(price);
    priceAfterDiscount = int.parse(price) - getPrice;

    return priceAfterDiscount.toString();
  }

  String calculateRealPrice(int qty, String discount, String price) {
    double totalAmount = 0;
    debugPrint(discount);
    debugPrint(qty.toString());
    String result = calculateDiscount(discount, price);

    totalAmount = double.parse(result) * qty;
    debugPrint('total amount : $totalAmount');
    return totalAmount.toString();
  }
}
