import 'package:app/Features/HomeView/manger/Cubit/Cubit.dart';
import 'package:app/Features/HomeView/manger/Cubit/CubitStates.dart';
import 'package:app/Features/HomeView/presentation/Views/widgets/CustomListTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuTaskesView extends StatelessWidget {
  const MenuTaskesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocProvider.of<AppCubit>(context).newTasks.isNotEmpty
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return customListTile(
                      BlocProvider.of<AppCubit>(context).newTasks[index],
                      context);
                },
                separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                itemCount: BlocProvider.of<AppCubit>(context).newTasks.length)
            : const CustomText();
      },
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Taskes Yet,Pleaze add Some Taskes',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
