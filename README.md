# Figma Frame Inspector

A Flutter plugin to verify how accurately the Figma frame was implemented in the app (whether paddings and elements sizes are correct).

With this tool any developer can verify all the paddings, font styles and elements sizes matches design specification in Figma.

TODO: Insert screen recoding of the tool.

## How it works

This plugin provides `FigmaFrameInspector` widgets that render provided Figma frame on top of screen widget. This helps to check is the frame implementation. 

## Installation

TODO: Specify proper package
`flutter pub add *`

## Usage

### Get Figma Personal Access Token

-   In Figma go to **Account** -> **Personal Access Tokens**
-   Generate a new token

### Get Figma Frame URL

-   In Figma open design file
-   On the left side in **Layers** section select a frame that you need to verify
-   Copy the URL of the frame

TODO: Inser screenshot of coping the URL

### Integration

-   `import 'package:figma_frame_inspector/figma_frame_inspector.dart';`
-   Wrap your app with `FigmaFrameInspector` widget:

```dart
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return FigmaFrameInspector( // <-- Wrap your screen widget with this widget.
      frameUrl:
          "<figma-frame-url>", // <-- Specify the Figma frame url. Looks like this: https://www.figma.com/file/<file_key>/<file_name >?node-id=<node_id>
      figmaToken: '<figma-token>', // <-- Specify the Figma `Personal access token` from Account Settings page.
      // Optional parameters:
      scale: 3, // A number between `0.01` and `4`, the image scaling factor.
      initialOpacity: .3, // Opacity of the frame on the screen start (default `30%`).
      enabled: true, // Enable or disable the frame overlay (default `true`).
      isTouchToChangeOpacityEnabled: true, // Enable or disable vertical scroll to change the frame overlay opacity (default `true`).
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        floatingActionButton: const FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## Credits

This plugin was heavily inspired by [flutter_figma_preview](https://pub.dev/packages/flutter_figma_preview)

## License

Can be found [here](TODO: link to license).
