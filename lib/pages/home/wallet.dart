import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          Text('残高'),

          Center(
            child: Card(
              color: Color.fromARGB(255, 28, 105, 135),
              child: InkWell(
                splashColor: Colors.greenAccent.withAlpha(10),
                highlightColor: Colors.transparent,
                onTap: () {
                  // タップ時の処理
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Center(
                    child: Text('0' '円', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: WalletCard(),
          // )
        ],
      ),
    );
  }
}

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // alignment: AlignmentDirectional.topEnd,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          // child: GestureDetector(
          // onTap: () {
          //     setState(() {
          //         _isBookmarked = !_isBookmarked;
          //     });
          // },
          // child: Icon(
          // _isBookmarked
          // ? Icons.bookmark_sharp
          // : Icons.bookmark_outline_sharp,
          // color: Colors.green,
          // size: 28,
          // ),
          // ),
          // ),
        ],
      ),
    );
  }
}
