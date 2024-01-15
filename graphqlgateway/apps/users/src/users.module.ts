import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersResolver } from './users.resolver';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloFederationDriver, ApolloFederationDriverConfig } from '@nestjs/apollo';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './entities/user.entity';

@Module({  
  imports:[
    TypeOrmModule.forRoot({
      type:'mongodb',
      url:'mongodb://localhost/mulyamapan',
      synchronize: true,
      entities:[
        User
      ]
    }),
    TypeOrmModule.forFeature([User]),
    GraphQLModule.forRoot<ApolloFederationDriverConfig>({
      driver: ApolloFederationDriver,
      autoSchemaFile:{
        federation:2
      }
    })
  ],
  providers: [UsersResolver, UsersService],
})
export class UsersModule {}
