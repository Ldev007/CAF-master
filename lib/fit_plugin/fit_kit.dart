import 'package:fit_kit/fit_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class fitkit extends StatefulWidget {
  @override
  _fitkitState createState() => _fitkitState();
}

class _fitkitState extends State<fitkit> {

  double testcount=0;
  String result = '';
  Map<DataType, List<FitData>> results = Map();
  bool permissions;

  RangeValues _dateRange = RangeValues(1, 8);
  List<DateTime> _dates = List<DateTime>();
  double _limitRange = 0;

  DateTime get _dateFrom => _dates[_dateRange.start.round()];
  DateTime get _dateTo => _dates[_dateRange.end.round()];
  int get _limit => _limitRange == 0.0 ? null : _limitRange.round();
  DateTime now;
  @override
  void initState() {
    super.initState();

    now = DateTime.now();
    _dates.add(null);
    for (int i = 7; i >= 0; i--) {
      _dates.add(DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i)));
    }
    _dates.add(null);

    hasPermissions();
  }




  Future<void> read() async {
    results.clear();
    print("read"+" "+now.toString()+"========"+_dateFrom.toString()+"==========="+_dateTo.toString()+now.subtract(Duration(days: 1)).toString()+"=========="+_limit.toString());
    try {
      permissions = await FitKit.requestPermissions(DataType.values);
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        for (DataType type in DataType.values) {
          try {
            results[type] = await FitKit.read(
              type,
              dateFrom: now.subtract(Duration(days: 1)),
              dateTo: now,
            );
          } on UnsupportedException catch (e) {
            results[e.dataType] = [];
          }
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }

    setState(() {});
    bool docount=false;
    testcount=0;
    final items =
    results.entries.expand((entry) => [entry.key, ...entry.value]).toList();
    items.forEach((element) {
      if (element is DataType) {
        print("=================="+element.toString()+"============================");
        if(element == DataType.STEP_COUNT){
          docount=true;
        }
        else{
          docount=false;
        }
      }
      else if(element is FitData){
        print(element.value.runtimeType);
        if(docount) {
          testcount = testcount + element.value;
        }
      }
    });
    //final item = items[index];
  }




  Future<void> revokePermissions() async {
    results.clear();

    try {
      await FitKit.revokePermissions();
      permissions = await FitKit.hasPermissions(DataType.values);
      result = 'revokePermissions: success';
    } catch (e) {
      result = 'revokePermissions: $e';
    }

    setState(() {});
  }

  Future<void> hasPermissions() async {
    try {
      permissions = await FitKit.hasPermissions(DataType.values);
    } catch (e) {
      result = 'hasPermissions: $e';
    }

    if (!mounted) return;

    setState(() {});
  }




  @override
  Widget build(BuildContext context) {
    final items =
    results.entries.expand((entry) => [entry.key, ...entry.value]).toList();
    print("=====fjhubiuyewrbiuviurew============="+testcount.toString()+"====================qwihcgyuswdgvhbw");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FitKit Example'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 8)),
              Text(
                  'Date Range: ${_dateToString(_dateFrom)} - ${_dateToString(_dateTo)}'),
              Text('Limit: $_limit'),
              Text('Permissions: $permissions'),
              Text('Result: $result'),
              _buildDateSlider(context),
              _buildLimitSlider(context),
              _buildButtons(context),
              Text(testcount.toString()),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    if (item is DataType) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          '$item - ${results[item].length}',
                          style: Theme.of(context).textTheme.title,
                        ),
                      );
                    } else if (item is FitData) {

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          item.value.toString(),
                          style: Theme.of(context).textTheme.caption,
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _dateToString(DateTime dateTime) {
    if (dateTime == null) {
      return 'null';
    }

    return '${dateTime.day}.${dateTime.month}.${dateTime.year}';
  }

  Widget _buildDateSlider(BuildContext context) {
    return Row(
      children: [
        Text('Date Range'),
        Expanded(
          child: RangeSlider(
            values: _dateRange,
            min: 0,
            max: 9,
            divisions: 10,
            onChanged: (values) => setState(() => _dateRange = values),
          ),
        ),
      ],
    );
  }

  Widget _buildLimitSlider(BuildContext context) {
    return Row(
      children: [
        Text('Limit'),
        Expanded(
          child: Slider(
            value: _limitRange,
            min: 0,
            max: 4,
            divisions: 4,
            onChanged: (newValue) => setState(() => _limitRange = newValue),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () => read(),
            child: Text('Read'),
          ),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
        Expanded(
          child: FlatButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () => revokePermissions(),
            child: Text('Revoke permissions'),
          ),
        ),
      ],
    );
  }
}