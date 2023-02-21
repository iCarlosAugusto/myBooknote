import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mybooknote/entities/anotation_entity.dart';

class AnotationPage extends StatelessWidget {
  AnotationPage({super.key, required this.data});

  AnotationEntity data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Text(
                  data.description,
                ),
              ),
              SizedBox(
                height: 250,
                child: ListView.separated(
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
                                                      File(data.images[index].url),
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
                                  File(data.images[index].url),
                                  fit: BoxFit.fill,
                                );
                              }),
                            ),
                          ],
                        ),
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: data.images.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
