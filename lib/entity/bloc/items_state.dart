import 'package:flutter_bloc_sync_refresh/entity/models/item.dart';

abstract class ItemsState {
  const ItemsState({this.items = const []});

  final List<Item> items;
}

class ItemsStateUninitialized extends ItemsState {}

class ItemsStateLoading extends ItemsState {}

class ItemsStateLoaded extends ItemsState {
  const ItemsStateLoaded(List<Item> items) : super(items: items);
}

class ItemsStateRefreshing extends ItemsState {}
