import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:newpro/model/product_model.dart';
import '../repository/product_repository.dart';



final editControllerProvider=StateProvider((ref) => ref.read(editRepositoryProvider));

class EditController {
  final EditRepository _editRepository;

  EditController({
    required EditRepository editRepository
  }) :_editRepository=editRepository;


  Future<void> updateData(Productmodel product) async {
    await _editRepository.updateData(product);
  }
}