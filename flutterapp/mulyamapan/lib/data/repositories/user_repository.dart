import 'dart:math';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mulyankan/core/graphql.dart';
import 'package:mulyankan/data/models/user/user_model.dart';

class UserRepository {
  Future<UserModel> signIn(
      {required String email, required String password}) async {
    //print("repository called");
    final query = '''
      query{
        signIn(email:"$email" , password:"$password"){
          id
          fullName
          email
          phoneNumber
          address
          city
          state
        }
      }            
    ''';
    //print("graphQL Query :-" + query);
    try {
      final result = await GraphQLConfig.performQuery(query);
      //print(result);
      final _user = result.data?['signIn'];
      if (_user == null) {
        throw "Username or Password not found !";
      }
      UserModel userModel = UserModel.fromJson(_user);
      return userModel;
    } catch (error) {
      //print("error occured" + error.toString());
      throw error;
    }
  }

  Future<String> saveProfile(UserModel userModel) async {
    final query = '''
      mutation(\$var_email:String, \$var_fullName:String!, \$var_address:String! , \$var_state:String!, \$var_city:String!, \$var_phoneNumber:String!){
        UpdateUser(updateUserInput:{
          email: \$var_email
          fullName:\$var_fullName
          address:\$var_address
          city:\$var_city
          state:\$var_state
          phoneNumber:\$var_phoneNumber
        }){
          id
        }
      }
    ''';

    Map<String, dynamic> variables = {
      "var_email": "${userModel.email}",
      "var_fullName": "${userModel.fullName}",
      "var_address": "${userModel.address}",
      "var_city": "${userModel.city}",
      "var_state": "${userModel.state}",
      "var_phoneNumber": "${userModel.phoneNumber}"
    };

    //print(query);
    try {
      final result = await GraphQLConfig.performMutation(query, variables);
      //print(result);
      final _user = result.data?['UpdateUser'];
      if (_user == null) {
        throw "User could not be updated !";
      }
      //UserModel userModel = UserModel.fromJson(_user);
      return "Successfully Updated !!";
    } catch (error) {
      //print("error occured" + error.toString());
      throw error;
    }
  }

  Future<UserModel> createAccount(
      {required String email, required String password}) async {
    //print("repository called");
    Random random = Random();
    int randomNumber = random.nextInt(100);

    final query = '''
      mutation(\$var_id:ID!, \$var_email:String, \$var_fullName:String!, \$var_password:String!  ){
        createUser(createUserInput: {
          id: \$var_id
          email: \$var_email
          fullName: \$var_fullName
          password: \$var_password
        }){
          id
          fullName
          email
        }
      }
    ''';

    Map<String, dynamic> variables = {
      "var_id": "$randomNumber",
      "var_email": "$email",
      "var_fullName": "",
      "var_password": "$password"
    };

    //print(query);
    try {
      final result = await GraphQLConfig.performMutation(query, variables);
      //print(result);
      final _user = result.data?['createUser'];
      if (_user == null) {
        throw "User could not be created !";
      }
      UserModel userModel = UserModel.fromJson(_user);
      return userModel;
    } catch (error) {
      //print("error occured" + error.toString());
      throw error;
    }
  }
}
