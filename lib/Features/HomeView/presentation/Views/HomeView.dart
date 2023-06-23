import 'package:app/Features/HomeView/manger/Cubit/Cubit.dart';
import 'package:app/Features/HomeView/manger/Cubit/CubitStates.dart';
import 'package:app/Features/HomeView/presentation/Views/widgets/CustomTextFomField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController timeditingController = TextEditingController();
  final TextEditingController titleeditingController = TextEditingController();
  final TextEditingController dateeditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocProvider(
        create: (context) =>
            AppCubit()..createDatabase(), //عايزين نشوف الحوار دا
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is AppInsertDatabaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Scaffold(
              key: scaffoldKey,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (BlocProvider.of<AppCubit>(context).isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<AppCubit>(context).insertToDatabase(
                          title: titleeditingController.text,
                          time: timeditingController.text,
                          date: dateeditingController.text);
                    }
                  } else {
                    BlocProvider.of<AppCubit>(context)
                        .changeBottomSheetState(isShow: true, icon: Icons.add);
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) {
                            return Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomTextFormField(
                                    controller: titleeditingController,
                                    type: TextInputType.text,
                                    prefixIcon: Icons.text_fields,
                                    text: 'Text Tile',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'value is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextFormField(
                                    controller: timeditingController,
                                    ontap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeditingController.text =
                                            value!.format(context);
                                      });
                                    },
                                    type: TextInputType.datetime,
                                    prefixIcon: Icons.watch_later_outlined,
                                    text: 'Task Time',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'value is required';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextFormField(
                                    controller: dateeditingController,
                                    ontap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2023-05-05'))
                                          .then((value) {
                                        dateeditingController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    type: TextInputType.datetime,
                                    prefixIcon: Icons.calendar_view_day_rounded,
                                    text: 'Task Date',
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'value is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          elevation: 20,
                        )
                        .closed
                        .then((value) {
                          BlocProvider.of<AppCubit>(context)
                              .changeBottomSheetState(
                                  isShow: false, icon: Icons.edit);
                        });
                  }
                },
                child: Icon(BlocProvider.of<AppCubit>(context).fabIcon),
              ),
              appBar: AppBar(
                title: Text(AppCubit.get(context)
                    .titles[AppCubit.get(context).currentIndex]),
              ),
              body: AppCubit.get(context)
                  .screens[AppCubit.get(context).currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: AppCubit.get(context).currentIndex,
                onTap: (index) {
                  AppCubit.get(context).changeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Menu',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: 'Archive',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
