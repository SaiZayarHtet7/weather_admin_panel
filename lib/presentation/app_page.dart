import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_admin_panel/bloc/noti_bloc.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var titleController = TextEditingController();
  var bodyTextController = TextEditingController();
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Noti"),
      ),
      body: BlocListener<NotiBloc, NotiState>(
        listener: (context, state) {
          if (state is NotiSendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green, content: Text("Success")));
          }
          if (state is NotiSendError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red, content: Text(state.error)));
          }
        },
        child: Form(
          key: key,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "title",
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter title';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: bodyTextController,
                decoration: InputDecoration(
                    hintText: "body",
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10))),
                validator: (value) {
                  if (value!.isEmpty) return 'Enter body';
                  return null;
                },
              ),
              BlocBuilder<NotiBloc, NotiState>(
                builder: (context, state) {
                  if (state is NotiSendLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MaterialButton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        context.read<NotiBloc>().add(SendNoti(
                            titleController.text.trim(),
                            bodyTextController.text.trim()));
                      }
                    },
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Send Noti",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}
