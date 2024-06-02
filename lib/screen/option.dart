import '../screen/pushOnOff.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../screen/profile.dart';

class optionScreen extends StatelessWidget {
  final BoxDecoration _containerDecoration = BoxDecoration(
    color: Color(0xff849F93),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  );

  final Divider _divider = Divider(
    thickness: 1,
    color: Color(0xffBDDBCE),
    indent: 3,
    endIndent: 12,
  );

  final Divider _divider2 = Divider(
    thickness: 2,
    color: Color(0xff849F93),
    indent: 3,
    endIndent: 12,
  );

  final TextStyle _listTitleStyle = TextStyle(
    color: Color(0xff5A715C),
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: _containerDecoration,
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xffFFFFFF),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildListTile(String title, {VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title, style: _listTitleStyle),
        ),
        _divider,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        appBar: AppBar(
          title: Text(
            '설정',
            style: TextStyle(
              color: Color(0xff5A715C),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: PRIMARY_COLOR,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // 계정 정보를 터치했을 때 수행할 동작
                  },
                  child: _buildSectionTitle('계정'),
                ),
                _divider2,
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: 8.0),
                  children: <Widget>[
                    _buildListTile('계정 정보', onTap: () {
                      // 계정 정보를 터치했을 때 수행할 동작
                    }),
                    _buildListTile('로그아웃', onTap: () {
                      // 로그아웃을 터치했을 때 수행할 동작
                    }),
                    _buildListTile('베타 | 프로필 설정', onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => profile()), // Profile은 프로필 화면을 나타내는 클래스명입니다.
                      );// 프로필 설정을 터치했을 때 수행할 동작
                    }),
                    _buildListTile('베타 | 친구 관리', onTap: () {
                      // 친구 관리를 터치했을 때 수행할 동작
                    }),
                  ],
                ),
                SizedBox(height: 20),
                _buildSectionTitle('알림'),
                _divider2,
                _buildListTile('알림 설정', onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => pushNotificationService()),
                  // );// 알림 설정을 터치했을 때 수행할 동작
                }),
                _buildSectionTitle('테마'),
                _divider2,
                _buildListTile('테마 변경', onTap: () {
                  // 테마 변경을 터치했을 때 수행할 동작
                }),
                _buildSectionTitle('앱 관리'),
                _divider2,
                _buildListTile('문의하기', onTap: () {
                  // 문의하기를 터치했을 때 수행할 동작
                }),
                _buildListTile('공지사항', onTap: () {
                  // 공지사항을 터치했을 때 수행할 동작
                }),
                _buildListTile('버전 1.0.2'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}