import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DinaTabView extends StatefulWidget {
  final List<Widget> children;
  final DinaTabController tabController;

  const DinaTabView(
      {Key key, @required this.children, @required this.tabController})
      : super(key: key);

  @override
  _DinaTabViewState createState() => _DinaTabViewState();
}

class _DinaTabViewState extends State<DinaTabView> {
  Map<String, bool> _mounted = Map();
  final PageStorageBucket bucket = PageStorageBucket();

  DinaTabController _tabController;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController ?? DinaTabController();
    final length = widget.children.length;
    if (length == 0) throw new Exception("children must be > 0");

    for (var i = 0; i < widget.children.length; i++) {
      _mounted['tab$i'] = false;
    }
    _mounted['tab0'] = true;

    _tabController.addListener(() {
      setIndex(_tabController.index);
    });
  }

  setIndex(int index) {
    if (_index == index) return;
    setState(() {
      _index = index;
      _mounted['tab$index'] = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: List.generate(widget.children.length, (index) {
        final isMounted = _mounted['tab$index'];
        return isMounted ? widget.children[index] : Container();
      }),
    );
  }
}

class DinaTabController extends ChangeNotifier {
  bool _isDisposed = false;

  int get index => _index;
  int _index;

  set index(int value) {
    assert(value != null);
    assert(value >= 0);
    if (_index == value) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  @mustCallSuper
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
