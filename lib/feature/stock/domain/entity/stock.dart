import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock.freezed.dart';
part 'stock.g.dart';

/// 종목 엔티티
@freezed
class Stock with _$Stock {
  const factory Stock({
    required String stockCode,
    required String stockName,
    String? logoUrl,
  }) = _Stock;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
}
