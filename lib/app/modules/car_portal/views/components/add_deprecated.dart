// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:fleet_app/app/shared/assets.dart';
// import 'package:fleet_app/app/shared/size.dart';
// import 'package:fleet_app/app/shared/text_view.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddCarDialog extends StatefulWidget {
//   @override
//   _AddCarDialogState createState() => _AddCarDialogState();
// }

// class _AddCarDialogState extends State<AddCarDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController carNameController = TextEditingController();

//   String? selectedVehicleType;
//   String? selectedFuelType;
//   String? selectedAvailability;
//   String? selectedMileage;

//   final List<String> vehicleTypes = ["Sedan", "SUV", "Truck", "Hatchback"];
//   final List<String> fuelTypes = ["Petrol", "Diesel", "Electric", "Hybrid"];
//   final List<String> availabilityOptions = ["Available", "Unavailable"];
//   final List<String> mileageOptions = ["0-10k", "10k-50k", "50k+"];

//   List<dynamic> _pickedImages = []; // Can hold both File and Uint8List

//   Future<void> pickImages() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//       withData: kIsWeb,
//     );

//     if (result != null) {
//       setState(() {
//         _pickedImages = result.files.map((file) {
//           if (kIsWeb) {
//             return file.bytes;
//           } else {
//             return File(file.path!);
//           }
//         }).toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       backgroundColor: Colors.white,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width * 0.7,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Add Car Details',
//                   style: GoogleFonts.poppins(
//                       fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 S.h(4),
//                 TextView(
//                   text: 'Fill the below information to add a new car',
//                   fontSize: 10,
//                   fontWeight: FontWeight.w400,
//                   color: Color(0xff6E7C87),
//                 ),
//                 SizedBox(height: 16),
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                           width: 0.4, color: Colors.grey.withOpacity(0.3)),
//                       borderRadius: BorderRadius.circular(8)),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomTextField(
//                         label: "Car Name",
//                         validator: (value) => value == null || value.isEmpty
//                             ? 'Car name is required'
//                             : null,
//                         controller: carNameController,
//                       ),
//                       SizedBox(height: 18),
//                       Row(
//                         children: [
//                           TextView(
//                             text: "Upload Car Images",
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           S.w(6.w),
//                           InkResponse(
//                             onTap: () => pickImages(),
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 5),
//                               decoration: BoxDecoration(
//                                   color: Colors.grey.withOpacity(0.02),
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(
//                                       color: Color(0xffDDE2E4), width: 0.8)),
//                               child: Row(
//                                 children: [
//                                   TextView(
//                                     text: 'Pick Images',
//                                     color: Color(0xff9AA6AC),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   S.w(4.w),
//                                   SvgPicture.asset(SvgAssets.edit, height: 14),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 12),
//                       _pickedImages.isNotEmpty
//                           ? SizedBox(
//                               height: 150,
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: _pickedImages.length,
//                                 itemBuilder: (context, index) {
//                                   final image = _pickedImages[index];

//                                   return Padding(
//                                     padding: const EdgeInsets.all(4.0),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(13),
//                                       child: image is Uint8List
//                                           ? Image.memory(
//                                               image,
//                                               width: 150,
//                                               height: 150,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.file(
//                                               image,
//                                               width: 150,
//                                               height: 150,
//                                               fit: BoxFit.cover,
//                                             ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             )
//                           : SizedBox.shrink(),
//                       SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomDropdown(
//                               label: "Vehicle Type",
//                               value: selectedVehicleType,
//                               items: vehicleTypes,
//                               onChanged: (val) =>
//                                   setState(() => selectedVehicleType = val),
//                               validator: (value) => value == null
//                                   ? 'Select a vehicle type'
//                                   : null,
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: CustomDropdown(
//                               label: "Fuel Type",
//                               value: selectedFuelType,
//                               items: fuelTypes,
//                               validator: (value) =>
//                                   value == null ? 'Select a fuel type' : null,
//                               onChanged: (val) =>
//                                   setState(() => selectedFuelType = val),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomDropdown(
//                               label: "Availability",
//                               value: selectedAvailability,
//                               items: availabilityOptions,
//                               validator: (value) =>
//                                   value == null ? 'Select availability' : null,
//                               onChanged: (val) =>
//                                   setState(() => selectedAvailability = val),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: CustomDropdown(
//                               label: "Mileage",
//                               value: selectedMileage,
//                               items: mileageOptions,
//                               validator: (value) =>
//                                   value == null ? 'Select milesage' : null,
//                               onChanged: (val) =>
//                                   setState(() => selectedMileage = val),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           _dialogButton(
//                             text: "Cancel",
//                             color: Colors.grey[100]!,
//                             textColor: Colors.grey,
//                             onPressed: () => Navigator.pop(context),
//                           ),
//                           S.w(10.w),
//                           _dialogButton(
//                             text: "Save Details",
//                             color: Colors.orange,
//                             textColor: Colors.white,
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {}
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// **Reusable Dialog Button**
//   Widget _dialogButton({
//     required String text,
//     required Color color,
//     required Color textColor,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       ),
//       onPressed: onPressed,
//       child: TextView(
//         text: text,
//         fontSize: 12,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//       ),
//     );
//   }
// }

// /// **Reusable TextField Widget**
// class CustomTextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;

//   const CustomTextField(
//       {required this.label, required this.controller, required this.validator});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextView(
//           text: label,
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//           fontSize: 13,
//         ),
//         SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           validator: validator,
//           style: TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             isDense: true,
//             contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Color(0xffDDE2E4), width: 0.2),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey, width: 0.4),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey, width: 0.4),
//               borderRadius: BorderRadius.circular(6),
//             ),
//             filled: true,
//             fillColor: Colors.grey.withOpacity(0.02),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// **Reusable Dropdown Widget**
// class CustomDropdown extends StatelessWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final Function(String?) onChanged;
//   final String? Function(String?)? validator;

//   const CustomDropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     required this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextView(
//           text: label,
//           color: Colors.black,
//           fontSize: 13,
//           fontWeight: FontWeight.w600,
//         ),
//         SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: value,
//           isExpanded: true,
//           validator: validator,
//           style: TextStyle(fontSize: 12),
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.5),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide:
//                   BorderSide(color: Colors.red.withOpacity(0.6), width: 1.5),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           ),
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black38),
//           items: items
//               .map((e) => DropdownMenuItem(
//                   value: e, child: TextView(text: e, fontSize: 12)))
//               .toList(),
//           onChanged: onChanged,
//         ),
//       ],
//     );
//   }
// }
