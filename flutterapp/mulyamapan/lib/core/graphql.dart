import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql/client.dart';
import 'package:http/http.dart' as http;

class GraphQLConfig {
  static final HttpLink httpLink = HttpLink(
    'http://172.17.96.1:3000/graphql',
    defaultHeaders: {'authorization': '1'},
    httpClient: InterceptorClient(),
  );

  static late GraphQLClient _client;

  static GraphQLClient get client {
    _client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
    return _client;
  }

  static Future<QueryResult> performQuery(String query,
      {Map<String, dynamic>? variables}) async {
    //print(query);
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );

    try {
      final result = await client.query(options);
      return result;
    } catch (error) {
      print("Error while calling GraphQL Query ${error.toString()}");
      throw error;
    }
  }

  static Future<QueryResult> performMutation(
      String query, Map<String, dynamic> variables) async {
    //print(query);
    final options = MutationOptions(document: gql(query), variables: variables);

    try {
      final result = await client.mutate(options);
      return result;
    } catch (error) {
      print("error in graphql Core : " + error.toString());
      throw error;
    }
  }
}

class InterceptorClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    try {
      // You can modify the request before sending it
      // For example, add headers:
      request.headers['authorization'] = '1';

      // Add your interceptor logic here
      print('Intercepted Request: ${request.url}');
      print('Intercepted Request: ${request.headers}');

      // Call the inner client to proceed with the request
      //return _inner.send(request);
      final response = await _inner.send(request);
      return response;
    } catch (ex) {
      print("Error while calling graphql endpoint ${ex.toString()}");
      rethrow;
    }
  }
}
