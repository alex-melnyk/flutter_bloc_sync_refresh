import 'dart:math' show Random;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sync_refresh/entity/bloc/items_event.dart';
import 'package:flutter_bloc_sync_refresh/entity/bloc/items_state.dart';
import 'package:flutter_bloc_sync_refresh/entity/models/item.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc() : super(ItemsStateUninitialized());

  final _random = Random();
  final _itemNames = [
    'PC',
    'Laptop',
    'Table',
    'Smartphone',
    'Mobile',
    'Server',
    'Modem',
    'Cell Phone',
    'Charger',
    'Cable',
  ];

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is ItemsEventLoadItems) {
      yield ItemsStateLoading();

      final generatedItems = _generateItems();
      yield ItemsStateLoaded(generatedItems);
    }

    if (event is ItemsEventRefresh) {
      yield ItemsStateRefreshing();

      final generatedItems = _generateItems();

      await Future<void>.delayed(Duration(seconds: 1));

      yield ItemsStateLoaded(generatedItems);
    }
  }

  List<Item> _generateItems() {
    return List<Item>.generate(
      50,
      (index) {
        return Item(
          _itemNames[_random.nextInt(_itemNames.length)],
          _random.nextDouble() * 300,
        );
      },
    );
  }
}
