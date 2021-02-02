import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sync_refresh/entity/bloc/bloc.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({
    Key key,
    @required this.blocContext,
    @required this.id,
  }) : super(key: key);

  final BuildContext blocContext;
  final int id;

  static MaterialPageRoute<void> route(BuildContext context, int id) => MaterialPageRoute(
        builder: (_) => ItemDetailsScreen(blocContext: context, id: id),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemsBloc>(
      create: (_) => BlocProvider.of<ItemsBloc>(blocContext),
      child: _ItemDetailsScreen(id: id),
    );
  }
}

class _ItemDetailsScreen extends StatefulWidget {
  const _ItemDetailsScreen({
    Key key,
    @required this.id,
  }) : super(key: key);

  final int id;

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<_ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsStateLoaded) {
            final item = state.items[widget.id];

            return Column(
              children: [
                ListTile(
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
                )
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
