import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sync_refresh/entity/bloc/bloc.dart';
import 'package:flutter_bloc_sync_refresh/entity/models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ItemsBloc()..add(ItemsEventLoadItems())),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        child: BlocBuilder<ItemsBloc, ItemsState>(
          buildWhen: (previous, current) => current is ItemsStateLoaded,
          builder: (context, state) {
            if (state is ItemsStateLoaded) {
              return _buildItemsList(state.items);
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItemsList(List<Item> items) {
    final theme = Theme.of(context);

    return ListView.separated(
      // ENABLE REFRESH IN
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = items[index];

        return ListTile(
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
}
