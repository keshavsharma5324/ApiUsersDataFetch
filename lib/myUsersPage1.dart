import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_cubit/flutter_cubit.dart';

import 'package:userdetails/base/base_state.dart';
import 'package:userdetails/cubit/user_cubit_page1.dart';
//import 'package:userdetails/data/api_client2.dart';
import 'package:userdetails/user_Model.dart';


import 'data/api_client2.dart';

getSnackBar(String msg, String actionLable, GlobalKey<ScaffoldState> key) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    content: Text(
      msg,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
    ),
    action: SnackBarAction(
      textColor: Colors.black87,
      label: actionLable,
      onPressed: () {
        // Some code to undo the change.
        key.currentState.hideCurrentSnackBar();
      },
    ),
  );
  return snackBar;
}

class MyUsers1 extends StatefulWidget {
  @override
  _MyUsers1State createState() => _MyUsers1State();
}

class _MyUsers1State extends State<MyUsers1> {
  UsersCubit1 _UsersCubit;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<Datum> data = [];

  @override
  void initState() {
    super.initState();

    _UsersCubit = UsersCubit1(apiClient2: ApiClient2());
  }

  @override
  Widget build(BuildContext context) {
    return CubitProvider(
        create: (context) => _UsersCubit,
        child: Scaffold(
          key: _globalKey,
          appBar: AppBar(title: Text("List of Users"),),
          body: CubitConsumer<UsersCubit1, BaseState>(
              builder: (_, state) {
                return UI();
              },
              listenWhen: (previous, current) => previous != current,
              buildWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if (state is LoadingState) {
                  // showLoader("Sending request");
                  print("State => LoadingState");
                }

                print("Outer State");
                if (state is SuccessState) {
                  // hideLoader();
                  print("SuccessState");
                  UserModel _userModel = UserModel.fromMap(state.response);
                  print("UsersDataLength => ${_userModel.data.length}");
                  setState(() {
                    data = _userModel.data;
                  });
                }

                if (state is ErrorState) {
                  print("error => ${state.message}");
                  // hideLoader();
                  print("ErrorState");
                  FocusScope.of(context).requestFocus(FocusNode());

                  ScaffoldMessenger.of(context).showSnackBar(
                      getSnackBar(state.message, "OK", _globalKey));
                }
              }),
        ));
  }

  Widget UI() {
    return Container(
      color: Color(0xffF4F6F8),
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(vertical: 55, horizontal: 10),
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
              
                data.length == 0
                    ? Column(
                        children: [
                          SizedBox(
                            height: 39,
                          ),
                          
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                           
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      )
                    : Flexible(
                        child: Container(
                            child: ListView.builder(
                          itemCount: data.length == 0 ? 0 : data.length,
                          itemBuilder: (context, index) {
                            //data = data[index];
                            // Users _UsersModel = data[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 22.0,
                                  backgroundImage:
                                      NetworkImage("${data[index].avatar}"),
                                  backgroundColor: Colors.transparent,
                                ),
                                title: Text(
                                  data[index].firstName +
                                      " " +
                                      data[index].lastName,
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPans',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3D3D3D),
                                  ),
                                ),
                                subtitle: Text(
                                  "Email- " + data[index].email,
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPans',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff3D3D3D),
                                  ),
                                ),
                                trailing: Text(
                                  "ID : " + data[index].id.toString(),
                                  style: TextStyle(
                                    fontFamily: 'SourceSansPans',
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff3D3D3D),
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
