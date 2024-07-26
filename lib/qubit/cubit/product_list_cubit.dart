import 'package:bloc/bloc.dart';
import 'package:learnbloc/apiService/api_client.dart';
import 'package:learnbloc/models/product_model.dart';

import 'package:meta/meta.dart';

part 'product_list_state.dart';

// class ProductListCubit extends Cubit<ProductListState> {
//   ProductListCubit() : super(ProductListInitial());
//   getProduct() async {
//     if (await isNetworkAbailabe()) {
//       emit(ProductListLoading());
//       ApiClient().getProduct().then((value) {
//         emit(ProductListLoaded(value!));
//       }).onError(
//         (error, stackTrace) {
//           print(error);
//           emit(ProductListModelError());
//         },
//       );
//     } else {
//       print('NetworkError');
//       emit(ProductListNetworkError());
//     }
//   }
// }
class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit() : super(ProductListInitial());
  getProduct() async {
    emit(ProductListLoading());
    ApiClient().getProduct().then((value) {
      emit(ProductListLoaded(value!));
    }).onError(
      (error, stackTrace) {
        print(error);
        emit(ProductListModelError());
      },
    );
  }
}
