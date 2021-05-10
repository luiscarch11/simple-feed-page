import 'package:flutter/material.dart' hide Title;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/add_content_form/add_content_form_notifier.dart';
import '../../domain/providers.dart';
import '../../domain/shared/age/positive_number.dart';
import '../../domain/shared/post/description/description.dart';
import '../../domain/shared/post/event_post.dart';
import '../../domain/shared/post/title/title.dart';
import '../../domain/shared/unique_id/unique_id.dart';
import '../shared/rounded_button_widget.dart';
import '../shared/snackbar.dart';
import '../shared/text_field_widget.dart';
import 'date_selector_widget.dart';
import 'loading_widget.dart';
import 'map_selector_dialog.dart';

class AddContentFormWidget extends StatefulWidget {
  const AddContentFormWidget({
    Key? key,
    this.event,
    this.onCreated,
    this.onEdited,
  })  : assert((event != null && onEdited != null) ||
            (event == null && onCreated != null)),
        super(key: key);
  final EventPost? event;
  final Function(UniqueId)? onCreated;
  final Function(UniqueId)? onEdited;
  @override
  _AddContentFormWidgetState createState() => _AddContentFormWidgetState();
}

class _AddContentFormWidgetState extends State<AddContentFormWidget> {
  late TextEditingController locationFieldController;

  @override
  void initState() {
    locationFieldController = TextEditingController(text: '');
    if (widget.event != null) {
      Future.delayed(
          Duration.zero,
          () => context
              .read(insertionFormNotifierProvider.notifier)
              .initWithDefaultValue(widget.event!));

      locationFieldController.text =
          '${widget.event!.location.latitude.getOrCrash()}, ${widget.event!.location.longitude.getOrCrash()}';
    } else {
      Future.delayed(
        Duration.zero,
        () => context
            .read(insertionFormNotifierProvider.notifier)
            .initWithoutDefault(),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Consumer(
                builder: (context, watch, _) => TextFieldWidget(
                  initialValue: widget.event?.post.title.getOrCrash(),
                  showError: watch(insertionFormNotifierProvider).showError,
                  validator: (value) => Title(value ?? '').value.fold(
                        (l) => l.map(
                          empty: (_) => 'Can\'t be empty',
                          tooLong: (_) =>
                              'Maximum ${Title.maxCharacters} characters',
                          tooShort: (_) =>
                              'Minimum ${Title.minCharacters} characters',
                        ),
                        (r) => null,
                      ),
                  onChanged: (value) =>
                      watch(insertionFormNotifierProvider.notifier)
                          .changeTitle(value),
                  headerText: 'Title',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer(
                builder: (context, watch, child) => TextFieldWidget(
                  showError: watch(insertionFormNotifierProvider).showError,
                  headerText: 'Description',
                  initialValue: widget.event?.post.description.getOrCrash(),
                  maxLines: 10,
                  validator: (value) => Description(value ?? '').value.fold(
                        (l) => l.map(
                          empty: (_) => 'Can\'t be empty',
                          tooLong: (_) =>
                              'Maximum ${Description.maxCharacters} characters',
                          tooShort: (_) =>
                              'Minimum ${Description.minCharacters} characters',
                        ),
                        (r) => null,
                      ),
                  onChanged: (value) =>
                      watch(insertionFormNotifierProvider.notifier)
                          .changeDescription(value),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer(
                builder: (context, watch, child) => DateSelectorTextFieldWidget(
                  showError: watch(insertionFormNotifierProvider).showError,
                  value: watch(insertionFormNotifierProvider).eventDate,
                  onChanged: (value) {
                    watch(insertionFormNotifierProvider.notifier)
                        .changeEventDate(value);
                  },
                  closeFunction: () {
                    watch(insertionFormNotifierProvider.notifier)
                        .changeCalendarShowStatus();
                  },
                  closeOnChanged: true,
                  isHidden:
                      !watch(insertionFormNotifierProvider).calendarIsExpanded,
                ),
              ),
              Consumer(
                builder: (context, watch, child) => TextFieldWidget(
                  isNumeric: true,
                  showError: watch(insertionFormNotifierProvider).showError,
                  headerText: 'How much is the people maximum?',
                  initialValue:
                      widget.event?.maximumPeople.getOrCrash().toString(),
                  validator: (value) => PositiveNumber(value ?? '').value.fold(
                        (l) => l.map(
                          empty: (_) => 'Can\'t be empty',
                          invalid: (_) => 'Invalid number',
                          tooSmall: (_) =>
                              'Minimum ${PositiveNumber.minimum} characters',
                        ),
                        (r) => null,
                      ),
                  onChanged: (value) =>
                      watch(insertionFormNotifierProvider.notifier)
                          .changeMaximumPeople(value),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProviderListener<AddContentFormState>(
                provider: insertionFormNotifierProvider,
                onChange: (context, value) {
                  value.editContentFailureOrSuccessOption.fold(
                      () => null,
                      (a) => {
                            a.fold(
                              (l) => {
                                Navigator.pop(context),
                                showError(
                                  context,
                                  l.map(
                                    serverError: (_) => 'Server error',
                                  ),
                                )
                              },
                              (r) {
                                widget.onEdited!(context
                                    .read(insertionFormNotifierProvider)
                                    .id!);
                                Navigator.of(context).pop();
                                showSuccess(
                                  context,
                                  'Event edited successfully!',
                                );
                              },
                            ),
                            context
                                .read(insertionFormNotifierProvider.notifier)
                                .clearFailureOrSuccess(),
                          });
                  value.addContentFailureOrIdOption.fold(
                    () => null,
                    (a) => {
                      a.fold(
                        (l) => {
                          Navigator.pop(context),
                          showError(
                            context,
                            l.map(
                              serverError: (_) => 'Server error',
                            ),
                          )
                        },
                        (r) {
                          widget.onCreated!(r);
                          Navigator.of(context).pop();
                          showSuccess(
                            context,
                            'Event added successfully!',
                          );
                        },
                      ),
                      context
                          .read(insertionFormNotifierProvider.notifier)
                          .clearFailureOrSuccess(),
                    },
                  );
                  locationFieldController.text = value.location == null
                      ? ''
                      : '${value.location!.latitude}, ${value.location!.longitude}';
                },
                child: Consumer(
                  builder: (context, watch, child) => TextFieldWidget(
                    isDisabled: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => MapSelectorWidget(
                          onSaved: (latlng) {
                            context
                                .read(insertionFormNotifierProvider.notifier)
                                .changeLocation(latlng);
                          },
                        ),
                      );
                    },
                    controller: locationFieldController,
                    showError: watch(insertionFormNotifierProvider).showError,
                    validator: (val) =>
                        val?.isEmpty ?? false ? 'Can\'t be empty' : null,
                    headerText: 'Location',
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Consumer(
                builder: (context, watch, child) => LoadingWidget(
                  loading: watch(insertionFormNotifierProvider).loading,
                  child: RoundedButtonWidget(
                    text: 'Submit',
                    onTap: () => watch(insertionFormNotifierProvider.notifier)
                        .submit(context
                            .read(authNotifierProvider.notifier)
                            .currentUser!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
