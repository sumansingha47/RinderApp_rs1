import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app_rs2/models/reminder_model.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  final Function(Reminder) onReminderCreated;
  const AddTaskPage({Key? key, required this.onReminderCreated})
      : super(key: key);

  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  TextEditingController taskNameController = TextEditingController();
  DateTime? scheduleDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Add Task")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: [
              TextField(
                autofocus: true,
                controller: taskNameController,
                decoration: InputDecoration(hintText: "Task name"),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 170,
                child: CupertinoDatePicker(
                  onDateTimeChanged: (date) {
                    scheduleDate = date;
                    log(scheduleDate.toString());
                  },
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String taskName = taskNameController.text;
          if (taskName != "" && scheduleDate != null) {
            Reminder newReminder = Reminder(
                id: Uuid().v1(),
                taskName: taskName,
                scheduleDate: scheduleDate);
            widget.onReminderCreated(newReminder);
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
