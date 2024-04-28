import 'dart:math';
import 'package:flutter/material.dart';
import 'package:local_data_base/data_base/student_db.dart';
import 'package:local_data_base/models/student_model_class.dart';

StudentDb studentDb = StudentDb();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Random random = Random();
  Future<List<StudentModelClass>>? list;
  late TextEditingController rollNoTextEditingController;
  late TextEditingController feeTextEditingController;
  late TextEditingController nameTextEditingController;
  bool isAnimation = true;
  late Tween<double> tween;
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    tween = Tween<double>(begin: 0, end: 1);
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = tween.animate(CurvedAnimation(
        parent: animationController, curve: Curves.bounceInOut));
    ////
    rollNoTextEditingController = TextEditingController();
    feeTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    rollNoTextEditingController.dispose();
    feeTextEditingController.dispose();
    nameTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    var radius = min(width, height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Crued Operation'),
      ),
      body: FutureBuilder<List<StudentModelClass>>(
        future: studentDb.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                      barrierColor: Colors.grey,
                      context: context,
                      builder: (context) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/edit.png',
                              width: width * 0.3,
                              height: height * 0.3,
                            ),
                            Image.asset(
                              'assets/images/delete.png',
                              width: width * 0.3,
                              height: height * 0.3,
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: InkWell(
                    onLongPress: () {},
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(
                              256,
                              random.nextInt(256),
                              random.nextInt(256),
                              random.nextInt(256),
                            ),
                            child:
                                Text(snapshot.data![index].rollNo.toString())),
                        title: Text(snapshot.data![index].name.toString()),
                        subtitle: Text(snapshot.data![index].fee.toString()),
                        trailing: GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                studentDb.deleteStudent(
                                  StudentModelClass(
                                      rollNo: snapshot.data![index].rollNo,
                                      fee: snapshot.data![index].fee,
                                      name: snapshot.data![index].name),
                                );
                              },
                            );
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator(
              color: Color.fromARGB(
                256,
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isAnimation = false;
            animationController.forward();
          });

          await Future.delayed(const Duration(seconds: 1));
          animationController.reset();
          if (!mounted) return;
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    insetPadding: const EdgeInsets.all(12),
                    shadowColor: Colors.grey,
                    surfaceTintColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    backgroundColor: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: radius * 0.15,
                            backgroundImage:
                                const AssetImage('assets/images/download.png'),
                          ),
                          TextFormField(
                            controller: rollNoTextEditingController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter student rollNo',
                              labelText: 'RollNo',
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: nameTextEditingController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: 'Enter student Name',
                              labelText: 'Name',
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: feeTextEditingController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Enter student fee',
                              labelText: 'Fee',
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  StudentDb studentDb = StudentDb();

                                  setState(() {
                                    studentDb.insertStudent(
                                      StudentModelClass(
                                        rollNo: int.parse(
                                          rollNoTextEditingController.text
                                              .toString(),
                                        ),
                                        fee: double.parse(
                                          feeTextEditingController.text
                                              .toString(),
                                        ),
                                        name: nameTextEditingController.text
                                            .toString(),
                                      ),
                                    );
                                  });

                                  Navigator.pop(context);
                                },
                                child: FittedBox(
                                  child: Text(
                                    'Insert',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        tooltip: 'Add',
        child: AnimatedIcon(
            icon: isAnimation == isAnimation
                ? AnimatedIcons.add_event
                : AnimatedIcons.close_menu,
            progress: animationController),
      ),
    );
  }
}

deleteUpdateFun(
    {required BuildContext context,
    required VoidCallback delete,
    required VoidCallback edit}) {
  showDialog(
      context: context,
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: edit,
              child: Image.asset('assets/images/edit.png'),
            ),
            GestureDetector(
              onTap: delete,
              child: Image.asset('assets/images/delete.png'),
            ),
          ],
        );
      });
}

class CustomDialog extends StatefulWidget {
  final TextEditingController nameTextEditingController;
  final TextEditingController feeTextEditingController;
  final TextEditingController rollNoTextEditingController;
  const CustomDialog(
      {super.key,
      required this.feeTextEditingController,
      required this.nameTextEditingController,
      required this.rollNoTextEditingController});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController nameTextEditingController;
  late TextEditingController feeTextEditingController;
  late TextEditingController rollNoTextEditingController;
  @override
  void initState() {
    super.initState();
    nameTextEditingController = widget.nameTextEditingController;
    feeTextEditingController = widget.feeTextEditingController;
    rollNoTextEditingController = widget.rollNoTextEditingController;
  }

  @override
  Widget build(BuildContext context) {
    print('buildsdnjknsjkdnksjnkjs');
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    var radius = min(width, height);
    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: radius * 0.15,
              backgroundImage: const AssetImage('assets/images/download.png'),
            ),
            TextFormField(
              controller: widget.rollNoTextEditingController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter student rollNo',
                labelText: 'RollNo',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: widget.nameTextEditingController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Enter student Name',
                labelText: 'Name',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: widget.feeTextEditingController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter student fee',
                labelText: 'Fee',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //await Future.delayed(const Duration(seconds: 1));
                    StudentDb studentDb = StudentDb();

                    studentDb.insertStudent(
                      StudentModelClass(
                        rollNo: int.parse(
                          widget.rollNoTextEditingController.text.toString(),
                        ),
                        fee: double.parse(
                          widget.feeTextEditingController.text.toString(),
                        ),
                        name: widget.nameTextEditingController.text.toString(),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: FittedBox(
                    child: Text(
                      'Insert',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

