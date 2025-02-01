import 'package:example/theme.dart';
import 'package:example/widgets/card_highlight.dart';
import 'package:example/widgets/page.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class TeachingTipPage extends StatefulWidget {
  const TeachingTipPage({Key? key}) : super(key: key);

  @override
  State<TeachingTipPage> createState() => _TeachingTipPageState();
}

class _TeachingTipPageState extends State<TeachingTipPage> with PageMixin {
  final nonTargetedController = FlyoutController();

  static const alignments = {
    'Bottom left': Alignment.bottomLeft,
    'Bottom center': Alignment.bottomCenter,
    'Bottom right': Alignment.bottomRight,
    'Center': Alignment.center,
    'Top left': Alignment.topLeft,
    'Top center': Alignment.topCenter,
    'Top right': Alignment.topRight,
  };
  static const placements = {
    'Bottom left': FlyoutPlacementMode.bottomLeft,
    'Bottom center': FlyoutPlacementMode.bottomCenter,
    'Bottom right': FlyoutPlacementMode.bottomRight,
    'Center': FlyoutPlacementMode.left,
    'Top left': FlyoutPlacementMode.topLeft,
    'Top center': FlyoutPlacementMode.topCenter,
    'Top right': FlyoutPlacementMode.topRight,
  };
  late String alignment = 'Bottom center';
  final targetedController = FlyoutController();

  @override
  void dispose() {
    nonTargetedController.dispose();
    targetedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final appTheme = context.watch<AppTheme>();

    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Teaching Tip')),
      children: [
        description(
          content: const Text(
            'A teaching tip is a semi-persistent and content-rich flyout '
            'that provides contextual information. It is often used for '
            'informing, reminding, and teaching users about important and new '
            'features that may enhance their experience.',
          ),
        ),
        subtitle(
          content: const Text('Show a non-targeted TeachingTip with buttons'),
        ),
        CardHighlight(
          codeSnippet: '''final teachingTip = TeachingTip(
  title: Text('Change themes without hassle'),
  subtitle: Text(
    'It's easier to see control samples in both light and dark theme',
  ),
  buttons: <Widget>[
    Button(
      child: const Text('Toggle theme now'),
      onPressed: () {
        // toggle theme here

        // then close the popup
        Navigator.of(context).pop();
      },
    ),
    Button(
      child: const Text('Got it'),
      onPressed: Navigator.of(context).pop,
    ),
  ],
),

showTeachingTip(
  context: context,
  teachingTip: teachingTip,
);''',
          child: Row(children: [
            FlyoutTarget(
              controller: nonTargetedController,
              child: Button(
                child: const Text('Show TeachingTip'),
                onPressed: () {
                  showTeachingTip(
                    flyoutController: nonTargetedController,
                    nonTargetedAlignment: alignments[alignment],
                    placementMode: placements[alignment]!,
                    builder: (context) => TeachingTip(
                      title: const Text('Change themes without hassle'),
                      subtitle: const Text(
                        'It\'s easier to see control samples in both light and dark theme',
                      ),
                      buttons: [
                        Button(
                          child: const Text('Toggle theme now'),
                          onPressed: () {
                            if (theme.brightness.isDark) {
                              appTheme.mode = ThemeMode.light;
                            } else {
                              appTheme.mode = ThemeMode.dark;
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                        Button(
                          onPressed: Navigator.of(context).pop,
                          child: const Text('Got it'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 18.0),
            SizedBox(
              width: 150.0,
              child: ComboBox<String>(
                placeholder: const Text('Alignment'),
                items: List.generate(alignments.length, (index) {
                  final entry = alignments.entries.elementAt(index);

                  return ComboBoxItem(
                    value: entry.key,
                    child: Text(entry.key.uppercaseFirst()),
                  );
                }),
                value: alignment,
                onChanged: (a) {
                  if (a != null) setState(() => alignment = a);
                },
              ),
            ),
          ]),
        ),
//         subtitle(
//           content: const Text('Show a targeted TeachingTip'),
//         ),
//         CardHighlight(
//           child: Row(
//             children: [
//               Button(
//                 child: const Text('Show TeachingTip'),
//                 onPressed: () {
//                   targetKey.currentState?.showTeachingTip(builder: (context) {
//                     return const TeachingTip(
//                       alignment: Alignment.bottomCenter,
//                       placementMargin: EdgeInsets.all(20.0),
//                       title: Text('Change themes without hassle'),
//                       subtitle: Text(
//                         'It\'s easier to see control samples in both light and dark theme',
//                       ),
//                     );
//                   });
//                 },
//               ),
//               const Spacer(),
//               TeachingTipTarget(
//                 key: targetKey,
//                 child: Container(
//                   height: 100,
//                   width: 200,
//                   color: theme.accentColor.defaultBrushFor(theme.brightness),
//                 ),
//               ),
//             ],
//           ),
//           codeSnippet: '''final teachingTip = TeachingTip(
//   title: Text('Change themes without hassle'),
//   subtitle: Text(
//     'It's easier to see control samples in both light and dark theme',
//   ),
//   buttons: <Widget>[
//     Button(
//       child: const Text('Toggle theme now'),
//       onPressed: () {
//         // toggle theme here

//         // then close the popup
//         Navigator.of(context).pop();
//       },
//     ),
//     Button(
//       child: const Text('Got it'),
//       onPressed: Navigator.of(context).pop,
//     ),
//   ],
// ),

// showTeachingTip(
//   context: context,
//   teachingTip: teachingTip,
// );''',
//         ),
      ],
    );
  }
}
