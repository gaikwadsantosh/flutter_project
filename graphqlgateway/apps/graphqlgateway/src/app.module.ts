import { IntrospectAndCompose, RemoteGraphQLDataSource } from '@apollo/gateway';
import { ApolloGatewayDriver, ApolloGatewayDriverConfig } from '@nestjs/apollo';
import { Module } from '@nestjs/common';
import {GraphQLModule} from '@nestjs/graphql'
import { authContext } from './auth.context';

@Module({
  imports: [
    GraphQLModule.forRoot<ApolloGatewayDriverConfig>({
      driver: ApolloGatewayDriver,
      server:{
        context:authContext
      },
      gateway:{
        supergraphSdl: new IntrospectAndCompose({
          subgraphs:[
            {
             name:'categories',
              url:'http://localhost:3003/graphql', 
            },
            {
              name:'subcategories',
              url:'http://localhost:3004/graphql', 
            },
            {
              name:'products',
              url:'http://localhost:3005/graphql', 
            },
            {
              name:'ecommercedata',
              url:'http://localhost:3006/graphql', 
            },
            {
              name:'users',
              url:'http://localhost:3007/graphql', 
            },
          ]
        }),
        buildService({url}){
          return new RemoteGraphQLDataSource({
            url,
            willSendRequest({request, context}){
              request.http.headers.set('user', context.user? JSON.stringify(context.user) : null,);
            },
          });
        },
      },
    }),
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
