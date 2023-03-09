import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surveyjs_projile/ui/screens/home/home_controller.dart';


class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.handleForm();
        },
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.documents.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(controller.documents[index].formName??""),
                  subtitle: Text(controller.documents[index].formResponse.toString()),
                  onTap: () {
                    controller.goToFormFormModel(controller.documents[index]);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
