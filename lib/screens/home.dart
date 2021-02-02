import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sync_refresh/entity/bloc/bloc.dart';
import 'package:flutter_bloc_sync_refresh/screens/screens.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemsBloc()..add(ItemsEventLoadItems()),
      child: _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter BLoC/Refresh Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          // ignore: close_sinks
          final itemsBloc = BlocProvider.of<ItemsBloc>(context)..add(ItemsEventRefresh());

          return itemsBloc.firstWhere((e) => e is! ItemsEventRefresh);
        },
        child: _buildItemsList(),
      ),
    );
  }

  Widget _buildItemsList() {
    final theme = Theme.of(context);

    return BlocBuilder<ItemsBloc, ItemsState>(
      buildWhen: (previous, current) => current is ItemsStateLoaded,
      builder: (context, state) {
        if (state is ItemsStateLoaded) {
          final items = state.items;

          return ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = items[index];

              return ListTile(
                onTap: () => _handleItemPressed(index),
                title: Text(
                  item.name,
                  style: theme.textTheme.headline6.copyWith(
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text('Description...'),
                trailing: Text(
                  '\$ ${item.price.toStringAsFixed(2)}',
                  style: theme.textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: items.length,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _handleItemPressed(int index) {
    Navigator.of(context).push(ItemDetailsScreen.route(context, index));
  }
}
