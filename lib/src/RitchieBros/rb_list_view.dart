import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'rb_item.dart';
import 'rb_item_details_view.dart';

class RBItemListView extends StatelessWidget {
  const RBItemListView({
    super.key,
    this.items = const [RBItem(1), RBItem(2), RBItem(3)],
  });

  static const routeName = '/';

  final List<RBItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RB Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView.builder(
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text('RB Item ${item.id}'),
              leading: const CircleAvatar(
                foregroundImage: AssetImage('assets/images/flutter_logo.png'),
              ),
              onTap: () {
                Navigator.restorablePushNamed(
                  context,
                  SampleItemDetailsView.routeName,
                );
              });
        },
      ),
    );
  }
}
