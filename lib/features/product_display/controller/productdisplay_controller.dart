import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/model/product_model.dart';

import '../repository/productdisplay_repository.dart';

final productdisplayprovider = Provider((ref) => ProductDisplayController(
    productdisplayRepository: ref.read(ProductdisplayRepositoryProvider)));

final productdisplayStreamProvider = StreamProvider(
        (ref) => ref.read(productdisplayprovider).getProductStream());

class ProductDisplayController {
  final ProductDisplayRepository _productdisplayRepository;

  ProductDisplayController({
    required ProductDisplayRepository productdisplayRepository,
  }) : _productdisplayRepository = productdisplayRepository;

  Stream<List<Productmodel>> getProductStream() {
    return _productdisplayRepository.view();
  }

void delete(String productId) {
  _productdisplayRepository.delete(productId);
}
}