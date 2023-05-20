import 'package:dictionary_app/models/found_model.dart';
import 'package:dictionary_app/models/not_found_model.dart';
import 'package:dictionary_app/utils/string_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

Dio dio = Dio();

class SearchProvider extends ChangeNotifier {
  bool isFound = false;
  bool isLoading = false;
  bool isSearched = false;
  late FoundModel foundModel;
  late NotFoundModel notFoundModel;

  SearchProvider();

  search(String search) async {
    try {
      isLoading = true;
      notifyListeners();
      String url = StringConstants.url + search;
      Response response = await dio.get(url, options: Options(
        validateStatus: (status) {
          return status == 200 || status == 404;
        },
      ));
      if (response.statusCode == 200) {
        isFound = true;
        isSearched = true;
        isLoading = false;
        List temp = response.data;
        List<FoundModel> list =
            temp.map((e) => FoundModel.fromJson(e)).toList();
        foundModel = list.first;
        notifyListeners();
        return response;
      } else if (response.statusCode == 404) {
        isFound = false;
        isSearched = true;
        isLoading = false;
        notFoundModel = notFoundModelFromJson(response.data.toString());
        notifyListeners();
        return response;
      }
      return response;
    } on DioError catch (e) {
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print("Dio error $e");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
