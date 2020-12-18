import 'package:flutter_bloc_sync_refresh/entity/models/item.dart';

class ItemsState {}

class ItemsStateUninitialized extends ItemsState {}

class ItemsStateLoading extends ItemsState {}

class ItemsStateLoaded extends ItemsState {
  ItemsStateLoaded(this.items);

  final List<Item> items;
}

class ItemsStateRefreshing extends ItemsState {}
