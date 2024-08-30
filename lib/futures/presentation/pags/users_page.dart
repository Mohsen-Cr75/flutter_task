import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/futures/domain/data_model.dart';
import 'package:flutter_task/futures/presentation/bloc/appcontroller/appcontroller_bloc.dart';

import '../../../widgets/personal_expansion.dart';
import '../bloc/apiloader/apiloader_bloc.dart';

class UsersDataPage extends StatefulWidget {
  const UsersDataPage({super.key});

  @override
  _UsersDataPageState createState() => _UsersDataPageState();
}

class _UsersDataPageState extends State<UsersDataPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
// جهت نشان دادن انیمیشنی داده های یوزر آنها را به ترتیب وارد این لیست خالی میکنیم و
//   لیست را به ترتیب همین لیست ایجاد میکنیم زیرا اگر به طور مستقیم از بلاک
//   داده ها را بگیریم و لیست را بسازیم انیمیشنی نخاهد بود
  List<Data> _items = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _addItems(List<Data> data) async {
    for (int i = 0; i < data.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      _items.add(data[i]);
      _listKey.currentState?.insertItem(
        i,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  Widget _buildItem(Data item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: PersonalExpansion(
        details: item.body,
        id: item.id,
        title: item.title,
        userId: item.userId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Users list'),
        ),
        body: BlocBuilder<AppControllerBloc, AppControllerState>(
            builder: (context, appState) {
          if (appState.connectivityResult == ConnectivityResult.wifi ||
              appState.connectivityResult == ConnectivityResult.mobile ||
              appState.connectivityResult == ConnectivityResult.vpn) {
            // اگر دستگاه به هر طریقی آنلاین بود api را فراخوانی بکن
            context.read<ApiLoaderBloc>().add(const LoadUsersFromApi());
          }
          // برای وقتی که  دستگاه آفلاین بود
          return appState.connectivityResult == ConnectivityResult.none
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('You are offline'),
                        SizedBox(
                          height: 50,
                        ),
                        Icon(
                          Icons.wifi_off_rounded,
                          color: Colors.red,
                        )
                      ]),
                )
              : BlocBuilder<ApiLoaderBloc, ApiloaderState>(
                  builder: (context, state) {
                    // اگر  State داده ای داشت و داده در شرایط مطلوب بود
                    if (state.response.statusCode == 200 && _items.isEmpty) {
                      // داده ها را برای ایجاد لیست انیمیشنی به تابع مورد نظر ارسال بکن
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _addItems(state.response.users);
                      });
                    }
                    //   به صورت پیشفرض با '' مقدار دهی شده است ولی به هر تغییری واکنش نشان میدهد  :  title
                    // پس اگر هنوز هیچ متغییر به آ اختصاص نیافته یعنی هنوز هیچ اتفاقی در برنامه رخ نداده است
                    return state.response.title == ''
                        // پس لودینگ را نشان بده
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 30,
                              ),
                              Text("Loading")
                            ],
                          ))

                        // اگر title بدون مقدار نبود پس یک تغییراتی در برنامه ایجاد شده است

                        :Center(

                            child: state.response.statusCode == 200
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    height: MediaQuery.of(context).size.height *
                                        0.85,
                                    child: AnimatedList(
                                      key: _listKey,
                                      initialItemCount: _items.length,
                                      itemBuilder: (context, index, animation) {
                                        return _buildItem(
                                          _items[index],
                                          animation,
                                        );
                                      },
                                    ),
                                  )
                                : state.response.statusCode == 400
                                    ? Column(
                                        children: [
                                          Text(state.response.title),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                          state.response.statusCode.toString(),style: const TextStyle(color: Colors.redAccent),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Text(state.response.title),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                          state.response.statusCode.toString(),style:const TextStyle(color: Colors.redAccent),
                                          )
                                        ],
                                      ),
                          );
                  },
                );
        }));
  }
}
