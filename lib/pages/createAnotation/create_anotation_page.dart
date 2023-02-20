import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/pages/createAnotation/create_anotation_controller.dart';
import 'package:mybooknote/widgets/textfieldWidget.dart';

class CreateAnotation extends StatelessWidget {
  CreateAnotation({super.key, required this.subjectID});
  String subjectID;

  @override
  Widget build(BuildContext context) {
    CreateAnotationController controller = CreateAnotationController(subjectID: subjectID);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formKey,
          child: Column(
            children: [
              TextfieldWidget(
                controller: controller.titleTextfieldController,
                labelText: 'Nome da anotação',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigátório';
                  }
                  return null;
                },
              ),
              TextfieldWidget(
                controller: controller.descriptionTextfieldController,
                labelText: 'Descrição',
                margin: const EdgeInsets.only(top: 16),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigátório';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  InkWell(
                    onTap: controller.pickImageFromGalery,
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, right: 6),
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.image_outlined, color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: controller.pickImageFromCamera,
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, right: 6),
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Icon(Icons.camera, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 250,
                child: Observer(builder: (_) {
                  return ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Stack(
                            children: [
                              InkWell(
                                onLongPress: () {
                                  //subjectController.selectImage(subjectController.images[index]);
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Row(
                                          children: [
                                            InkWell(
                                              onTap: () => print('Compartilhar!'),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [Icon(Icons.share), Text('Compartilhar')],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () => print('Excluir!'),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [Icon(Icons.delete), Text('Excluir')],
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) => MediaQuery(
                                            data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
                                            child: SafeArea(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    color: Colors.black,
                                                    child: Center(
                                                      child: Image.file(
                                                        File(controller.images[index].url),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                      onPressed: () => context.pop(),
                                                      icon: const Icon(
                                                        Icons.close_rounded,
                                                        color: Colors.white,
                                                        size: 32,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ));
                                },
                                child: Observer(builder: (_) {
                                  return Image.file(
                                    File(controller.images[index].url),
                                    fit: BoxFit.fill,
                                  );
                                }),
                              ),
                            ],
                          ),
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemCount: controller.images.length);
                }),
              ),
              ElevatedButton(onPressed: controller.createAnotation, child: const Text('Criar'))
            ],
          ),
        ),
      ),
    );
  }
}
