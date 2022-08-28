import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

typedef ValueWidgetBuilder2<T, T2> = Widget Function(
    BuildContext context, T value1, T2 value2, Widget? child);

class ValueListenableBuilder2<T, T2> extends StatefulWidget {
  const ValueListenableBuilder2({
    Key? key,
    required this.valueListenable1,
    required this.valueListenable2,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<T> valueListenable1;
  final ValueListenable<T2> valueListenable2;
  final ValueWidgetBuilder2<T, T2> builder;
  final Widget? child;

  @override
  State<StatefulWidget> createState() => _ValueListenableBuilder2State<T, T2>();
}

class _ValueListenableBuilder2State<T, T2>
    extends State<ValueListenableBuilder2<T, T2>> {
  late T value1;
  late T2 value2;

  @override
  void initState() {
    super.initState();
    value1 = widget.valueListenable1.value;
    value2 = widget.valueListenable2.value;
    widget.valueListenable1.addListener(_valueChanged1);
    widget.valueListenable2.addListener(_valueChanged2);
  }

  @override
  void didUpdateWidget(ValueListenableBuilder2<T, T2> oldWidget) {
    if (oldWidget.valueListenable1 != widget.valueListenable1 &&
        oldWidget.valueListenable2 != widget.valueListenable2) {
      oldWidget.valueListenable1.removeListener(_valueChanged1);
      value1 = widget.valueListenable1.value;
      widget.valueListenable1.addListener(_valueChanged1);

      oldWidget.valueListenable2.removeListener(_valueChanged2);
      value2 = widget.valueListenable2.value;
      widget.valueListenable2.addListener(_valueChanged2);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.valueListenable1.removeListener(_valueChanged1);
    widget.valueListenable2.removeListener(_valueChanged2);
    super.dispose();
  }

  void _valueChanged1() {
    setState(() {
      value1 = widget.valueListenable1.value;
    });
  }

  void _valueChanged2() {
    setState(() {
      value2 = widget.valueListenable2.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, value1, value2, widget.child);
  }
}
