import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../../domain/shared/post/event_post.dart';
import '../../domain/shared/user.dart';
import '../shared/colors.dart';
import '../shared/rounded_button_widget.dart';
import 'expanded_event_widget.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    Key? key,
    required this.event,
    required this.currentUser,
  }) : super(key: key);
  final EventPost event;
  final User currentUser;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: FeedColors.light,
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 5),
            color: FeedColors.grey,
          ),
          BoxShadow(
            offset: Offset(-3, 5),
            color: FeedColors.grey,
          ),
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ' has created a new event',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
                text: event.post.publisher.name.getOrCrash(),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: FeedColors.blue,
                    ),
              ),
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
                  zoom: 16,
                  target: LatLng(
                    event.location.latitude.getOrCrash(),
                    event.location.longitude.getOrCrash(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
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
              height: 10,
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
              height: 20,
            ),
            Center(
              child: RoundedButtonWidget(
                text: 'See more',
                fractionalWidth: .6,
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => ExpandedEventWidget(
                    event: event,
                    currentUser: currentUser,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
