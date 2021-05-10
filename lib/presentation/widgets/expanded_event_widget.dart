import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../domain/providers.dart';
import '../../domain/shared/post/event_post.dart';
import '../../domain/shared/user.dart';
import '../shared/colors.dart';
import 'add_content_form.dart';

class ExpandedEventWidget extends StatelessWidget {
  const ExpandedEventWidget({
    Key? key,
    required this.event,
    required this.currentUser,
  }) : super(key: key);
  final EventPost event;
  final User currentUser;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            currentUser.id == event.post.publisher.id
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'You have created this event',
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: FeedColors.success,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            isScrollControlled: true,
                            isDismissible: true,
                            builder: (context) => AddContentFormWidget(
                              event: event,
                              onEdited: (postId) {
                                context
                                    .read(feedPageNotifierProvider.notifier)
                                    .changeValueForPost(postId);
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: ' has created a new event',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          ],
                          text: event.post.publisher.name.getOrCrash(),
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: FeedColors.blue,
                                  ),
                        ),
                      ),
                    ],
                  ),
            Text(
              event.post.title.getOrCrash(),
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: GoogleMap(
                zoomControlsEnabled: false,
                markers: {
                  Marker(
                    markerId: MarkerId(event.post.id.getOrCrash()),
                    position: LatLng(
                      event.location.latitude.getOrCrash(),
                      event.location.longitude.getOrCrash(),
                    ),
                  ),
                },
                initialCameraPosition: CameraPosition(
                  zoom: 4,
                  target: LatLng(
                    event.location.latitude.getOrCrash(),
                    event.location.longitude.getOrCrash(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Event date:',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(event.date),
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assistants',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: FeedColors.blue,
                    ),
                    Text(
                      '${event.assistants.length.toString()} / ${event.maximumPeople.getOrCrash()}',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: event.assistants.length ==
                                    event.maximumPeople.getOrCrash()
                                ? FeedColors.error
                                : null,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              event.post.description.getOrCrash(),
              style: TextStyle(),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
