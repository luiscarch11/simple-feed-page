import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../application/map_selector/map_selector_notifier.dart';
import '../../domain/providers.dart';
import '../shared/rounded_button_widget.dart';
import 'loading_widget.dart';

class MapSelectorWidget extends StatefulWidget {
  const MapSelectorWidget({Key? key, required this.onSaved}) : super(key: key);
  final Function(LatLng?) onSaved;

  @override
  _MapSelectorWidgetState createState() => _MapSelectorWidgetState();
}

class _MapSelectorWidgetState extends State<MapSelectorWidget> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () => context.read(mapSelectorNotifierProvider.notifier).init(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ProviderListener<MapSelectorState>(
        provider: mapSelectorNotifierProvider,
        onChange: (context, value) {},
        child: Consumer(builder: (context, watch, _) {
          final state = watch(mapSelectorNotifierProvider);
          final notifier = watch(mapSelectorNotifierProvider.notifier);
          return LoadingWidget(
            loading: state.loading,
            child: Stack(
              children: [
                GoogleMap(
                    zoomControlsEnabled: false,
                    markers: {
                      Marker(
                        markerId: MarkerId('s'),
                        position: state.markLocation ??
                            state.userLocation ??
                            LatLng(0, 0),
                      )
                    },
                    initialCameraPosition: CameraPosition(
                      zoom: 16,
                      target: state.markLocation ??
                          state.userLocation ??
                          LatLng(0, 0),
                    ),
                    onTap: (argument) => notifier.changeMarkLocation(argument)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RoundedButtonWidget(
                      fractionalWidth: .6,
                      text: 'Save',
                      onTap: () {
                        Navigator.of(context).pop();
                        widget
                            .onSaved(state.markLocation ?? state.userLocation);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
