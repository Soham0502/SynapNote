import 'package:flutter/material.dart';

class Uihelper{
  static CustomImage({required String img}) {
  return Image.asset(
    "assets/images/$img", 
    fit: BoxFit.contain,
  );
}

  static CustomText({required String text, required Color color, required FontWeight fontweight, String? fontFamily, required double fontsize}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontsize,
        fontWeight: fontweight,
        color: color,
        fontFamily: fontFamily,
      ),
    );
  }

  static CustomTextField ({required TextEditingController controller}){
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Color(0xFF000000),
        )
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(5),
          hintText: "User ID",
          prefixIcon: Image.asset("assets/images/user.png"),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: 40,
          ),
          ),
        ),
      );
  }


static CustomPasswordField({required TextEditingController controller, bool obscureText = true}) {
  return Container(
    height: 50,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      border: Border.all(
        color: Color(0xFF000000),
      )
    ),
    child: TextField(
      style: TextStyle(
        color: Colors.black
      ),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(5),
        hintText: "Password",
        prefixIcon:Image.asset("assets/images/password.png"),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 40,
          maxWidth: 40,
        ),
      ),
    ),
  );
}


 static Widget CustomButton(VoidCallback callback) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFF27AF34),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          "Login",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Color(0xFF27AF34),
          ),
        ),
      ),
    ),
  );
}


}