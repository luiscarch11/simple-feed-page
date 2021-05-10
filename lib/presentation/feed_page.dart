import 'package:flutter/material.dart' hide Title;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/providers.dart';
import 'widgets/add_content_form.dart';
import 'widgets/event_widget.dart';
import 'widgets/loading_widget.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();

    context
        .read(feedPageNotifierProvider.notifier)
        .init(context.read(authNotifierProvider.notifier).currentUser!);
    super.initState();
    _controller.addListener(
      () {
        if (_controller.position.pixels >=
                _controller.position.maxScrollExtent - 20 &&
            !context.read(feedPageNotifierProvider).loadingMoreEvents) {
          context.read(feedPageNotifierProvider.notifier).requestMoreEvents();
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final state = watch(feedPageNotifierProvider);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) => AddContentFormWidget(
                  onCreated: (id) {
                    context
                        .read(feedPageNotifierProvider.notifier)
                        .addNewPostToFeed(id);
                    _controller.animateTo(
                      0,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      curve: Curves.linear,
                    );
                  },
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          body: SingleChildScrollView(
            controller: _controller,
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Center(
                child: LoadingWidget(
                  loading: state.loadingFeed,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Stack(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.eventPostsToShow.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                EventWidget(
                                  event: state.eventPostsToShow[index],
                                  currentUser: context
                                      .read(authNotifierProvider.notifier)
                                      .currentUser!,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          if (state.loadingMoreEvents) ...[
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ]
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
