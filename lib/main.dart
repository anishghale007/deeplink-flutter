import 'package:deeplink/home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protocol_handler/protocol_handler.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => Scaffold(
        appBar: AppBar(title: const Text('Home Screen')),
      ),
      routes: [
        GoRoute(
          path: 'hello',
          builder: (_, __) => Scaffold(
            appBar: AppBar(title: const Text('Details Screen')),
          ),
        ),
      ],
    ),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await protocolHandler.register('myprotocol');
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // routerConfig: router,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   final _navigatorKey = GlobalKey<NavigatorState>();
//   late AppLinks _appLinks;
//   StreamSubscription<Uri>? _linkSubscription;
//   String? link;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     initDeepLinks();
//   }

//   @override
//   void dispose() {
//     _linkSubscription?.cancel();
//     super.dispose();
//   }

//   Future<void> initDeepLinks() async {
//     _appLinks = AppLinks();

//     // Check initial link if app was in cold state (terminated)
//     final appLink = await _appLinks.getLatestAppLinkString();
//     // final appLink = await _appLinks.getInitialAppLink();
//     if (appLink != null) {
//       setState(() {
//         link = appLink.toString();
//       });
//       // if (link.toString().contains('/hello')) {
//       //   if (mounted) {
//       //     Navigator.of(context).push(MaterialPageRoute(
//       //       builder: (context) => const SecondScreen(),
//       //     ));
//       //   }
//       // }
//     }

//     // Handle link when app is in warm state (front or background)
//     _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
//       setState(() {
//         link = uri.toString();
//         // uri.removeFragment();
//       });
//       // if (uri.toString().contains('/hello')) {
//       //   Navigator.of(context).push(MaterialPageRoute(
//       //     builder: (context) => const SecondScreen(),
//       //   ));
//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               link ?? 'Empty',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final _navigatorKey = GlobalKey<NavigatorState>();
//   late AppLinks _appLinks;
//   StreamSubscription<Uri>? _linkSubscription;

//   @override
//   void initState() {
//     super.initState();

//     initDeepLinks();
//   }

//   @override
//   void dispose() {
//     _linkSubscription?.cancel();

//     super.dispose();
//   }

//   Future<void> initDeepLinks() async {
//     _appLinks = AppLinks();

//     // Check initial link if app was in cold state (terminated)
//     final appLink = await _appLinks.getInitialAppLink();
//     if (appLink != null) {
//       log('getInitialAppLink: $appLink');
//       openAppLink(appLink);
//     }

//     // Handle link when app is in warm state (front or background)
//     _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
//       log('onAppLink: $uri');
//       openAppLink(uri);
//     });
//   }

//   void openAppLink(Uri uri) {
//     _navigatorKey.currentState?.pushNamed(uri.fragment);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: _navigatorKey,
//       initialRoute: "/",
//       onGenerateRoute: (RouteSettings settings) {
//         Widget routeWidget = defaultScreen();

//         // Mimic web routing
//         final routeName = settings.name;
//         if (routeName != null) {
//           if (routeName.startsWith('/hello/')) {
//             // Navigated to /book/:id
//             // routeWidget = customScreen(
//             //   routeName.substring(routeName.indexOf('/book/')),
//             // );
//             routeWidget = customScreen();
//           } else if (routeName == '/hello') {
//             // Navigated to /book without other parameters
//             // routeWidget = customScreen("None");
//             routeWidget = customScreen();
//           }
//         }

//         return MaterialPageRoute(
//           builder: (context) => routeWidget,
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       },
//     );
//   }

//   Widget defaultScreen() {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Default Screen')),
//       body: const Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SelectableText('''
//             Launch an intent to get to the second screen.

//             On web:
//             http://localhost:<port>/#/book/1 for example.

//             On windows & macOS, open your browser:
//             sample://foo/#/book/hello-deep-linking

//             This example code triggers new page from URL fragment.
//             '''),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget customScreen() {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Second Screen')),
//       body: const Center(child: Text('Second Screen')),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff416ff4),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xffF7F9FB),
        dividerColor: Colors.grey.withOpacity(0.3),
      ),
      home: const HomePage(),
    );
  }
}
