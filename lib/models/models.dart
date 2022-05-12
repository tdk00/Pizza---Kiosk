class Product {
  final int id, categoryId;
  final String name, img;
  final List<ProductSize> sizes;
  Product(this.id, this.categoryId, this.name, this.img, this.sizes);
}

class ProductSize {
  final int id;
  final String name;
  final String barkod;
  final double price;
  ProductSize( this.id, this.name, this.barkod, this.price );
}


class Category {
  final int id, isDefault;
  final String name, icon;
  Category(this.id, this.name, this.icon, this.isDefault);
}

class BasketProduct {
  final int id, categoryId, count;
  final String name, img, barkod;
  final double price;
  BasketProduct(this.id, this.categoryId, this.name, this.img, this.barkod, this.count, this.price);
}

class ShoppingCartProduct {
  final int shopping_cart_product_id, product_id, size_id, product_count;
  final String session_id, name, size_name, image, barkod;
  final double price_including_extras, total;
  ShoppingCartProduct(
      this.shopping_cart_product_id,
      this.product_id,
      this.size_id,
      this.product_count,
      this.session_id,
      this.name,
      this.size_name,
      this.image,
      this.barkod,
      this.price_including_extras,
      this.total);
}

class Extra {
  final int id, shopping_cart_extra_id, size_id, extra_count, extra_default_count;
  final String name, image, barkod;
  final double price;
  Extra(this.id, this.shopping_cart_extra_id, this.size_id, this.extra_count, this.extra_default_count, this.name, this.image, this.barkod, this.price);
}