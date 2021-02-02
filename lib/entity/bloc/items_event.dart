import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemsEventLoadItems extends ItemsEvent {}

class ItemsEventRefresh extends ItemsEvent {}
