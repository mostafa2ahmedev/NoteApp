import 'package:app/Features/HomeView/manger/Cubit/Cubit.dart';
import 'package:app/Features/HomeView/manger/Cubit/CubitStates.dart';
import 'package:app/Features/HomeView/presentation/Views/widgets/CustomListTile.dart';
import 'package:app/Features/HomeView/presentation/Views/widgets/MenuTaskesView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchieveTaskesView extends StatelessWidget {
  const ArchieveTaskesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocProvider.of<AppCubit>(context).archivedTasks.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return customListTile(
                      BlocProvider.of<AppCubit>(context).archivedTasks[index],
                      context);
                },
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                itemCount:
                    BlocProvider.of<AppCubit>(context).archivedTasks.length)
            : const CustomText();
      },
    );
  }
}
