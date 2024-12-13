import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }

  // Configure routes with GoRouter
  final GoRouter _router = GoRouter(
    initialLocation: '/intro', // Start with the Intro Page
    routes: [
      // Introductory Page
      GoRoute(
        path: '/intro',
        builder: (context, state) => IntroPage(),
      ),

      // Parent Page with dynamic routes for headings
      GoRoute(
        path: '/parent/:heading',
        builder: (context, state) {
          final heading = state.pathParameters['heading'] ?? 'heading1';
          return ParentPage(selectedHeading: heading);
        },
      ),

      // Nested Parent Page with titles
      GoRoute(
        path: '/nested_parent/:title',
        builder: (context, state) {
          final title = state.pathParameters['title'] ?? 'title1';
          return NestedParentPage(selectedTitle: title);
        },
      ),
    ],
  );
}

// Intro Page
class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intro Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/parent/heading1'), // Navigate to Parent Page with default heading
          child: Text('Go to Parent Page'),
        ),
      ),
    );
  }
}

// Parent Page with dynamic content
class ParentPage extends StatelessWidget {
  final String selectedHeading;

  const ParentPage({required this.selectedHeading});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headings
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => context.go('/parent/heading1'), // Navigate to Heading 1
                child: Text(
                  'Heading 1',
                  style: TextStyle(
                    color: selectedHeading == 'heading1' ? Colors.blue : Colors.black,
                    fontWeight: selectedHeading == 'heading1' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/parent/heading2'), // Navigate to Heading 2
                child: Text(
                  'Heading 2',
                  style: TextStyle(
                    color: selectedHeading == 'heading2' ? Colors.blue : Colors.black,
                    fontWeight: selectedHeading == 'heading2' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/parent/heading3'), // Navigate to Heading 3
                child: Text(
                  'Heading 3',
                  style: TextStyle(
                    color: selectedHeading == 'heading3' ? Colors.blue : Colors.black,
                    fontWeight: selectedHeading == 'heading3' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          Divider(),

          // Dynamic Content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getContentForHeading(selectedHeading),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.go('/nested_parent/title1'), // Navigate to Nested Parent Page
                    child: Text('Go to Nested Parent Page'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to determine the widget for the selected heading
  Widget _getContentForHeading(String heading) {
    switch (heading) {
      case 'heading1':
        return Text(
          'Content for Heading 1',
          style: TextStyle(fontSize: 24),
        );
      case 'heading2':
        return Text(
          'Content for Heading 2',
          style: TextStyle(fontSize: 24),
        );
      case 'heading3':
        return Text(
          'Content for Heading 3',
          style: TextStyle(fontSize: 24),
        );
      default:
        return Text(
          'No Content Available',
          style: TextStyle(fontSize: 24),
        );
    }
  }
}

// Nested Parent Page with Titles
class NestedParentPage extends StatelessWidget {
  final String selectedTitle;

  const NestedParentPage({required this.selectedTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Parent Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => context.go('/nested_parent/title1'), // Navigate to Title 1
                child: Text(
                  'Title 1',
                  style: TextStyle(
                    color: selectedTitle == 'title1' ? Colors.blue : Colors.black,
                    fontWeight: selectedTitle == 'title1' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/nested_parent/title2'), // Navigate to Title 2
                child: Text(
                  'Title 2',
                  style: TextStyle(
                    color: selectedTitle == 'title2' ? Colors.blue : Colors.black,
                    fontWeight: selectedTitle == 'title2' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => context.go('/nested_parent/title3'), // Navigate to Title 3
                child: Text(
                  'Title 3',
                  style: TextStyle(
                    color: selectedTitle == 'title3' ? Colors.blue : Colors.black,
                    fontWeight: selectedTitle == 'title3' ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          Divider(),

          // Dynamic Content for Titles
          Expanded(
            child: Center(
              child: _getContentForTitle(selectedTitle),
            ),
          ),
        ],
      ),
    );
  }

  // Function to determine the widget for the selected title
  Widget _getContentForTitle(String title) {
    switch (title) {
      case 'title1':
        return Text(
          'Content for Title 1',
          style: TextStyle(fontSize: 24),
        );
      case 'title2':
        return Text(
          'Content for Title 2',
          style: TextStyle(fontSize: 24),
        );
      case 'title3':
        return Text(
          'Content for Title 3',
          style: TextStyle(fontSize: 24),
        );
      default:
        return Text(
          'No Content Available',
          style: TextStyle(fontSize: 24),
        );
    }
  }
}
