import 'package:dio/dio.dart';
import 'package:practical_test/Base/base_repository.dart';
import 'package:practical_test/Model/product_model.dart';
import 'package:practical_test/app/config/api_const.dart';
import 'package:practical_test/app/utils/dio_exception.dart';
import 'package:practical_test/app/utils/generic_convert.dart';

class HomeRepo extends BaseRepository {
  Future<List<Product>> getProducts() async {
    try {
      var response = await super.get(APICONST.product, data: {}, options: Options(headers: await super.getApiHeaders(true)));
      if (response?.statusCode == 200) {
        final responseData = Generics(response!.data["products"]).getAsList<Product>((p0) => Product.fromJson(p0));
        return responseData;
      } else {
        return [];
      }
    } on DioException catch (e) {
      DioExceptions.fromDioError(e).toString();
      if (e.response != null && e.response!.data != null && e.response!.data["settings"] != null) {
        return [];
      } else {
        return [];
      }
    }
  }
}
