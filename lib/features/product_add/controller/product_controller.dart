import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/model/product_model.dart';
import '../repository/product_repository.dart';


final controllerProvider = Provider((ref) => Controller(productRepository: ref.read(productRepositoryProvider)));
final productStreamProvider=Provider((ref) => ref.watch(streamProvider));

class Controller {
  final ProductAddRepository _productRepository;

  Controller({
    required ProductAddRepository productRepository,
  }) : _productRepository = productRepository;

  void add(Productmodel data)  {
    _productRepository.add(data);
  }


  // void deleted({required Productmodel delete}){
  //   _productRepository.delete(deleteItem: delete);
  // }
}