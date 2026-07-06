import 'package:prjgetxproduct/product/domain/entities/product.dart';

class Cart extends Product {
  Cart(
    super.id,
    super.name,
    super.code,
    super.price,
    super.stock,
    super.category,
    super.description,
    super.image,
  );
}
