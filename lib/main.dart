import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// 창고 데이터
class Model {
  int num;
  Model(this.num);
}

// 창고 class(상태, 행위) (Provider - 상태, StateNotifierProvider - 상태 + 메서드)
class ViewModel extends StateNotifier<Model?> {
  ViewModel(super.state);

  void init() {
    state = Model(1);
  }

  void change() {
    state = Model(2);
  }
}

// 창고 관리자
final numProvider = StateNotifierProvider<ViewModel, Model?>((ref) {
  return ViewModel(null)..init();
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MyText1(),
              MyText2(),
              MyText3(),
              MyButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends ConsumerWidget {
  const MyButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(numProvider.notifier).change();
      },
      child: Text("상태변경"),
    );
  }
}

class MyText3 extends StatelessWidget {
  const MyText3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("5", style: TextStyle(fontSize: 30));
  }
}

class MyText2 extends ConsumerWidget {
  const MyText2({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Model? model = ref.watch(numProvider);

    if (model == null) {
      return CircularProgressIndicator();
    } else {
      return Text("${model.num}", style: TextStyle(fontSize: 30));
    }
  }
}

class MyText1 extends ConsumerWidget {
  const MyText1({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Model? model = ref.watch(numProvider);

    if (model == null) {
      return CircularProgressIndicator();
    } else {
      return Text("${model.num}", style: TextStyle(fontSize: 30));
    }
  }
}
