import 'package:call_recorder/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeController>(
      create: (context) => HomeController(),
      child: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late HomeController controller;

  @override
  void initState() {
    controller = BlocProvider.of<HomeController>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeController, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.symmetric(
                      vertical: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextFormField(hintText: 'Enter mobile number', controller: controller.mobile, onChanged: controller.onChanged, keyboardType: TextInputType.number),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '+91 ${controller.mobile.text}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.dial,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Icon(Icons.call, size: 18, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      if (state is CallLogUpdated) ...[
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 10),
                        Text(
                          'Call Log:',
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${state.callLog?.duration} sec",
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${state.callLog?.name}",
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () => controller.playRecording(state.recordingPath),
                          child: Text("Play Recording"),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}