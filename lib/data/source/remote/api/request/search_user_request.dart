import 'package:structure_flutter_mobile/core/utils/constant.dart';
import 'package:structure_flutter_mobile/data/source/remote/api/request/base_request.dart';

class SearchUserRequest extends BaseRequest {
  final String keyword;
  final int page;
  final int limit;

  SearchUserRequest(this.keyword, {this.page, this.limit});

  @override
  List<Object> get props => [getUri(), keyword, page, limit];

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'q': keyword, 'page': page, 'per_page': limit};
  }

  @override
  String getUri() {
    return URLConstant.SEARCH_USERS;
  }
}
