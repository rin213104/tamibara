import '../const/colors.dart';
import 'package:flutter/material.dart';
import '../action/selectedImageModel.dart';
import '../action/nickNameProvider.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<profile> {
  bool isEditing = false;
  String editedNickname = '';
  List<String> friendList = [];
  List<String> searchResults = [];
  List<String> allUsers = ['asd asd@asd.com'];

  TextEditingController _searchController = TextEditingController();
  TextEditingController _searchDialogController = TextEditingController();
  bool isSearching = false;

  static const primaryDivider = Divider(
    thickness: 2,
    color: Color(0xff849F93),
    indent: 3,
    endIndent: 12,
  );

  static const secondaryDivider = Divider(
    thickness: 1,
    color: Color(0xffBDDBCE),
    indent: 3,
    endIndent: 12,
  );

  @override
  void dispose() {
    _searchController.dispose();
    _searchDialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nickname = Provider.of<nickNameProvider>(context).nickname;

    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        title: Text(
          '프로필',
          style: TextStyle(
            color: CHARACTER_COLOR,
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
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profileCircle.png',
                        width: 200,
                        height: 200,
                      ),
                      Image.asset(
                        Provider.of<SelectedImageModel>(context).selectedImage ?? 'assets/images/capybara/카피바라성년.png',
                        width: 140,
                        height: 150,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isEditing ? editedNickname : nickname,
                        style: TextStyle(
                          color: CHARACTER_COLOR,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          _showNicknameEditDialog(context, nickname);
                        },
                      )
                    ],
                  ),
                  Text(
                    'tamy@bara.com',
                    style: TextStyle(
                      color: CHARACTER_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '친구목록',
                            style: TextStyle(
                              color: CHARACTER_COLOR,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add_circle_outline),
                            onPressed: () {
                              _showAddFriendDialog(context);
                            },
                          )
                        ],
                      ),
                      primaryDivider,
                      for (String friend in friendList) ...[
                        _buildFriendTile(friend.split(' ')[0], friend.split(' ')[1]),
                        secondaryDivider,
                      ],
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildFriendTile(String name, String email) {
    return ListTile(
      title: Text(
        '$name   $email',
        style: TextStyle(
          color: CHARACTER_COLOR,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }

  void _showNicknameEditDialog(BuildContext context, String currentNickname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('닉네임 변경'),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '새 닉네임',
            ),
            onChanged: (value) {
              editedNickname = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Provider.of<nickNameProvider>(context, listen: false).setNickname(editedNickname);
                setState(() {
                  isEditing = false;
                });
                Navigator.of(context).pop();
              },
              child: Text('저장'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }

  void _showAddFriendDialog(BuildContext context) {
    _searchDialogController.clear();
    isSearching = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('친구 추가'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchDialogController,
                    decoration: InputDecoration(
                      hintText: '닉네임 또는 이메일을 입력하세요',
                    ),
                    onChanged: (value) {
                      setState(() {
                        isSearching = false;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        searchResults = allUsers.where((friend) => friend.startsWith(value)).toList();
                        isSearching = true;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  if (isSearching && searchResults.isEmpty)
                    Text(
                      '존재하지 않는 유저입니다.',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (isSearching && searchResults.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '검색 결과:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        for (String result in searchResults) ...[
                          ListTile(
                            title: Text(result),
                            onTap: () {
                              _confirmAddFriend(context, result);
                            },
                          ),
                        ],
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(() {
        searchResults.clear();
        isSearching = false;
      });
    });
  }

  void _confirmAddFriend(BuildContext context, String friend) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('친구 추가 확인'),
          content: Text('친구로 추가하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  friendList.add(friend);
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }
}