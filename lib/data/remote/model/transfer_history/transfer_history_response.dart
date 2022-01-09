
import 'package:dhoro_mobile/data/remote/model/transfer_history/transfer_history_data.dart';

class TransferHistoryDataResponse {
  int? count;
  String? next;
  String? previous;
  int? page;
  int? totalPages;
  ResultData? results;
  //List<TransferHistoryData>? data;

  TransferHistoryDataResponse({
    this.count,
    this.next,
    this.previous,
    this.page,
    this.totalPages,
    this.results});

  TransferHistoryDataResponse.fromJson(dynamic json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    page = json['page'];
    totalPages = json['total_pages'];
    results = json['results'] != null ? ResultData.fromJson(json['results']) : null;

  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['count'] = count;
    map['next'] = next;
    map['previous'] = previous;
    map['page'] = page;
    map['total_pages'] = totalPages;
    if (results != null) {
      map['results'] = results?.toJson();
    }
    return map;
  }

}