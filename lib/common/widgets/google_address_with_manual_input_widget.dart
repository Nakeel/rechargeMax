import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_max/common/widgets/searchable_drop_down_widget.dart';
import 'package:recharge_max/common/widgets/widgets.dart';
import 'package:recharge_max/core/network/response_status_enums.dart';

import 'address_autocomplete_input_field.dart';

class AddressInputField extends StatefulWidget {
  final String? label;
  final void Function(String address) onAddressSelected;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Function(String value)? onChanged;

  const AddressInputField({
    super.key,
     this.label,
    required this.onAddressSelected,
    this.validator,
    this.controller,
    this.onChanged
  });

  @override
  State<AddressInputField> createState() => _AddressInputFieldState();
}

class _AddressInputFieldState extends State<AddressInputField> {
  bool _manualMode = false;
  String? _selectedState;
  String? _selectedLGA;
  final _manualAddressController = TextEditingController();

  @override
  void initState() {
    // context
    //     .read<UtilsBloc>()
    //     .add(GetAllStatesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (!_manualMode) {
      return AddressAutocompleteWidget(
        controller: widget.controller,
        label: widget.label ?? "Address",
        isRequired: true,
        onChanged: widget.onChanged,
        onAddressSelected: widget.onAddressSelected,
        validator: widget.validator,
        onUseCurrentLocation: () {
          // handle current location
        },
        onManualEntry: () {
          setState(() {
            _manualMode = true;
            widget.controller?.clear();
          });
        },
      );
    // }

    // --- Manual Mode ---
    // return BlocBuilder<UtilsBloc, UtilsState>(
    //   builder: (context, state) {
    //     return Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         AppTextField(
    //           label: widget.label ?? 'Street Address',
    //           isRequired: true,
    //           controller: _manualAddressController,
    //           validator: widget.validator,
    //           onChanged: (val){
    //             final fullAddress =
    //                 '$val, ${_selectedLGA??''}, ${_selectedState??''}';
    //             widget.onAddressSelected(fullAddress);
    //           },
    //         ),
    //         const SizedBox(height: 8),
    //         Row(
    //           children: [
    //             Expanded(
    //               child: SearchableCustomDropdownWidget<String>(
    //                 labelText: 'State',
    //                 hintText: 'Select State',
    //                 isRequired: true,
    //                 showLoader: state.getAllStatesStatus ==
    //                     ResponseStatus.loading,
    //                 items: state.allStates.toList(),
    //                 selectedItem: _selectedState,
    //                 isMultiSelection: false,
    //                 validator: widget.validator,
    //                 itemAsString: (s) => s,
    //                 compareFn: (a, b) => a == b,
    //                 onChanged: (value) {
    //                   if (value != null) {
    //                     setState(() {
    //                       _selectedState = value;
    //                       _selectedLGA = null;
    //                     });
    //
    //                     final fullAddress =
    //                         '${_manualAddressController.text}, ${_selectedLGA??''}, ${_selectedState??''}';
    //                     widget.onAddressSelected(fullAddress);
    //                     context
    //                         .read<UtilsBloc>()
    //                         .add(GetLgasByStateEvent(value));
    //                   }
    //                 },
    //               ),
    //             ),
    //             const SizedBox(width: 8),
    //             Expanded(
    //               child: SearchableCustomDropdownWidget<String>(
    //                 labelText: 'LGA',
    //                 hintText: 'Select the LGA',
    //                 isRequired: true,
    //                 showLoader: state.getAllLgasStatus ==
    //                     ResponseStatus.loading,
    //                 items: state.allLgas.toList(),
    //                 selectedItem: _selectedLGA,
    //                 isMultiSelection: false,
    //                 validator: widget.validator,
    //                 itemAsString: (s) => s,
    //                 compareFn: (a, b) => a == b,
    //                 onChanged: (value) {
    //                   if (value != null) {
    //                     setState(() {
    //                       _selectedLGA = value;
    //                     });
    //
    //                     final fullAddress =
    //                         '${_manualAddressController.text}, $_selectedLGA, $_selectedState';
    //                     widget.onAddressSelected(fullAddress);
    //                   }
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //         const SizedBox(height: 8),
    //         TextButton(
    //           onPressed: () {
    //             setState(() {
    //               _manualMode = false;
    //               _selectedState = null;
    //               _selectedLGA = null;
    //               _manualAddressController.clear();
    //             });
    //           },
    //           child: const Text('Back to address search'),
    //         ),
    //         // ElevatedButton(
    //         //   onPressed: () {
    //         //     final fullAddress =
    //         //         '${_manualAddressController.text}, $_selectedLGA, $_selectedState';
    //         //     widget.onAddressSelected(fullAddress);
    //         //   },
    //         //   child: const Text("Use this address"),
    //         // ),
    //       ],
    //     );
    //   },
    // );
  }
}
