import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/data.dart';

void main() => runApp(CupertinoApp(
      home: FirstPage(),
      theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.systemBlue,
              darkColor: CupertinoColors.systemGreen),
          barBackgroundColor: CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.white, darkColor: CupertinoColors.black)),
    ));

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
          child: Center(
        child: CupertinoButton.filled(
          child: Text(
            "Next",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => MainPage(),
            ),
          ),
        ),
      ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CupertinoSliverNavigationBar(
              largeTitle: Text("Explore"),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.chevron_back, size: 28),
                onPressed: () async {
                  final isYes = await showCupertinoDialog(
                      context: context, builder: createDialog);
                },
              ),
            )
          ],
          body: SafeArea(
            child: GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3 / 4),
              itemCount: image.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CupertinoContextMenu(
                    //////////long press
                    actions: <Widget>[
                      CupertinoContextMenuAction(
                        child: Text("Copy"),
                        trailingIcon: CupertinoIcons.doc_on_doc,
                        onPressed: () {},
                      ),
                      CupertinoContextMenuAction(
                        child: Text("Share"),
                        trailingIcon: CupertinoIcons.share,
                        onPressed: () {},
                      ),
                      CupertinoContextMenuAction(
                        child: Text("Favorite"),
                        trailingIcon: CupertinoIcons.heart,
                        onPressed: () {},
                      ),
                      CupertinoContextMenuAction(
                        isDestructiveAction: true,
                        child: Text("Delete"),
                        trailingIcon: CupertinoIcons.delete,
                        onPressed: () {},
                      ),
                    ],
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(image[index], fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: Text(
          "Alerting You",
          style: TextStyle(fontSize: 22),
        ),
        content: Text(
          "Are you sure to leave this page?",
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () => Navigator.push(
                context, CupertinoPageRoute(builder: (context) => FirstPage())),
          ),
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: (() => Navigator.pop(context, false)),
          ),
        ],
      );
}
