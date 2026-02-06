import 'package:hive_flutter/hive_flutter.dart';
import 'package:realtime_item/feature/favorite/data/model/favorite_item_model.dart';

/// 관심 종목 로컬 데이터소스 인터페이스
abstract class FavoriteLocalDataSource {
  Future<List<FavoriteItemModel>> getAll();
  Future<FavoriteItemModel?> getByStockCode(String stockCode);
  Future<void> add(FavoriteItemModel item);
  Future<void> update(FavoriteItemModel item);
  Future<void> delete(String stockCode);
  Future<void> clear();
}

/// Hive를 사용한 관심 종목 로컬 데이터소스 구현체
class FavoriteLocalDataSourceImpl implements FavoriteLocalDataSource {
  static const String _boxName = 'favorite_items';

  Box<FavoriteItemModel>? _box;

  Future<Box<FavoriteItemModel>> get box async {
    if (_box != null && _box!.isOpen) {
      return _box!;
    }
    _box = await Hive.openBox<FavoriteItemModel>(_boxName);
    return _box!;
  }

  @override
  Future<List<FavoriteItemModel>> getAll() async {
    final b = await box;
    return b.values.toList();
  }

  @override
  Future<FavoriteItemModel?> getByStockCode(String stockCode) async {
    final b = await box;
    final items = b.values.where((item) => item.stockCode == stockCode);
    return items.isEmpty ? null : items.first;
  }

  @override
  Future<void> add(FavoriteItemModel item) async {
    final b = await box;
    await b.put(item.stockCode, item);
  }

  @override
  Future<void> update(FavoriteItemModel item) async {
    final b = await box;
    await b.put(item.stockCode, item);
  }

  @override
  Future<void> delete(String stockCode) async {
    final b = await box;
    await b.delete(stockCode);
  }

  @override
  Future<void> clear() async {
    final b = await box;
    await b.clear();
  }
}
