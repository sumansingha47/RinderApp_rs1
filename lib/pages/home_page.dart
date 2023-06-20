import 'dart:developer';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app_rs2/main.dart';
import 'package:reminder_app_rs2/models/reminder_model.dart';
import 'package:reminder_app_rs2/pages/add_task_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Reminder> reminders = [];

  void shortReminder() {
    reminders.sort((a, b) {
      return a.scheduleDate!.compareTo(b.scheduleDate!);
    });
    setState(() {});
  }

  String returnFormatedDate(DateTime scheduleDate) {
    String FormatDate =
        DateTimeFormat.format(scheduleDate, format: "D, d M y, h:m");
    return FormatDate;
  }

  Color returnColor(DateTime scheduleDate) {
    DateTime dateOfNow = DateTime.now();
    int differenceInDays = scheduleDate.difference(dateOfNow).inDays;

    if (differenceInDays <= 1) {
      return Colors.red;
    } else if (differenceInDays > 1 && differenceInDays <= 2) {
      return Colors.orange;
    } else if (differenceInDays > 2 && differenceInDays <= 4) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  void fetchReminder() async {
    List<Reminder> _reminders = await localStorage.fetchReminder();
    setState(() {
      reminders = _reminders;
    });
    shortReminder();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReminder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Reminder App"),
        backgroundColor: Colors.purple[600],
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(reminders[index].taskName.toString()),
            subtitle: Text(
              returnFormatedDate(reminders[index].scheduleDate!).toString(),
              style:
                  TextStyle(color: returnColor(reminders[index].scheduleDate!)),
            ),
            onLongPress: () async {
              Reminder reminderIndex = reminders[index];
              setState(() {
                reminders.remove(reminderIndex);
              });

              int deleteResult =
                  await localStorage.deleteReminder(reminderIndex);
              shortReminder();
              log(deleteResult.toString());
            },
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddTaskPage(
              onReminderCreated: (newReminder) async {
                setState(() {
                  reminders.add(newReminder);
                });
                int saveResult = await localStorage.saveReminder(newReminder);
                shortReminder();
                log(saveResult.toString());

                await localNotification.scheduleNotification("Task Reminder",
                    newReminder.taskName.toString(), newReminder.scheduleDate!);
              },
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
