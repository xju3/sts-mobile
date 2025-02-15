import 'package:duowoo/views/widgets/app_bar.dart';
import 'package:duowoo/views/widgets/menu_draw.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:duowoo/server/api/review_api.dart';
import 'package:duowoo/server/model/assignment.dart';
import 'package:duowoo/views/cards/review/assignment.dart';
import 'package:intl/intl.dart';
import 'package:duowoo/views/widgets/week_navigator.dart';
import 'package:loader_overlay/loader_overlay.dart';




class AssignmentPage extends StatefulWidget {
  const AssignmentPage({Key? key}) : super(key: key);

  @override
  _AssignmentPageState createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  List<Assignment> _assignments = [];
  int _selectedYear = DateTime.now().year;
  int _selectedWeek = _getWeekNumber(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadAssignments();
  }

  static int _getWeekNumber(DateTime date) {
    DateTime monday = date.subtract(Duration(days: date.weekday - 1));
    int dayOfYear = int.parse(DateFormat("D").format(monday));
    return ((dayOfYear + 6) / 7).floor();
  }

  Future<void> _loadAssignments() async {
    context.loaderOverlay.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = prefs.getString('studentId');
    if (studentId != null) {
      ReviewApi reviewApi = ReviewApi();
      List<Assignment> assignments = await reviewApi.getAssignments(
          studentId, _selectedYear, _selectedWeek);
      setState(() {
        _assignments = assignments;
      });
      context.loaderOverlay.show();
    }
  }

  void onWeekChanged(int yearId, int weekId) {
    setState(() {
      _selectedYear = yearId;
      _selectedWeek = weekId;
    });
    _loadAssignments();
  }

  void showQuestions(String? assignmentId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          "练习列表",
          [
            WeekNavigator(
              initialYear: _selectedYear,
              initialWeek: _selectedWeek,
              onWeekChanged: onWeekChanged,
            ),
          ],
          true),
      drawer: CustomDraw(),
      body: RefreshIndicator(
        onRefresh: _loadAssignments,
        child: ListView.builder(
          itemCount: _assignments.length,
          itemBuilder: (context, index) {
            var assignment = _assignments[index];
            return GestureDetector(
              onTap: () => showQuestions(assignment.id),
              child: AssignmentCard(assignment: assignment),
            );
          },
        ),
      ),
    );
  }
}
