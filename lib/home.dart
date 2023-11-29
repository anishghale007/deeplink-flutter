import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:protocol_handler/protocol_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ProtocolListener {
  String? _initialUrl = '';
  final List<String> _receivedUrlList = [];

  @override
  void initState() {
    protocolHandler.addListener(this);
    super.initState();

    _init();
  }

  @override
  void dispose() {
    protocolHandler.removeListener(this);
    super.dispose();
  }

  void _init() async {
    _initialUrl = await protocolHandler.getInitialUrl();
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.all(12),
          title: Text('$_initialUrl'),
          onTap: () async {
            _initialUrl = await protocolHandler.getInitialUrl();
            setState(() {});
          },
        ),
        const Text('Received urls'),
        for (String url in _receivedUrlList)
          Text(
            url,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  void onProtocolUrlReceived(String url) {
    log('Received Url: $url');
    setState(() {
      _receivedUrlList.add(url);
    });
  }
}
