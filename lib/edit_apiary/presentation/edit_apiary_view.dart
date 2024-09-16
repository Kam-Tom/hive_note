// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_note/core/configs/theme/app_colors.dart';
// import 'package:hive_note/edit_apiary/bloc/edit_apiary_bloc.dart';
// import 'package:logger/logger.dart';
// import 'package:reorderable_grid/reorderable_grid.dart';
// import 'package:repositories/repositories.dart';


// class EditApiaryView extends StatelessWidget {
//   const EditApiaryView({super.key});

//   @override
//   Widget build(BuildContext context) {

    
//     var status = context.watch<EditApiaryBloc>().state.status;
//     if(status == EditApiaryStatus.failure)
//       return Text('Failure');
//     if(status == EditApiaryStatus.loading)
//       return Text('Loading');
    
//     var state = context.watch<EditApiaryBloc>().state;
//     Apiary apiary = state.apiary!;
//     //List<Hive> hives = apiary.hives;
//     return 

//  BlocBuilder<EditApiaryBloc, EditApiaryState>(
//         builder: (context, state) {
//           if (true) {
//             final nameController = TextEditingController(text: apiary.name);
//             final orderController = TextEditingController(text: apiary.order.toString());

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: nameController,
//                       decoration: InputDecoration(labelText: 'Name'),
//                     ),
//                     TextFormField(
//                       controller: orderController,
//                       decoration: InputDecoration(labelText: 'Order'),
//                       keyboardType: TextInputType.number,
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         final updatedApiary = apiary.copyWith(
//                           name: nameController.text,
//                           order: int.tryParse(orderController.text) ?? apiary.order,

//                         );
//                         //context.read<EditApiaryBloc>().add(UpdateApiary(updatedApiary));
//                       },
//                       child: Text('Save'),
//                     ),
//                     Expanded(
//                       child: ReorderableGridView.extent(
//                                 maxCrossAxisExtent: 50,
//                                 onReorder: (a,b){
//                                   Logger().d("XCX $a -> $b");
//                                   // context.read<EditApiaryBloc>().add(RearangeHives(
//                                   //   hive1: hives[a],
//                                   //   hive2: hives[b],
//                                   // ));
//                                 },
//                                 childAspectRatio: 1,
//                                 children: hives.map((item) {
//                                   /// map every list entry to a widget and assure every child has a
//                                   /// unique key
//                                   return Card(
//                                     color: AppColors.secondaryLight,
//                                     key: ValueKey(item),
//                                     child: Center(
//                                       child: Text(item.name),
//                                     ),
//                                   );
//                                 }).toList(),
//                                       ),
//                     )],
//                 ),
//               ),
//             );
//           // } else if (state is EditApiaryLoading) {
//           //   return Center(child: CircularProgressIndicator());
//           // } else {
//           //   return Center(child: Text('Error loading apiary'));
//           // }
//         }
  
  
//   });
// }}