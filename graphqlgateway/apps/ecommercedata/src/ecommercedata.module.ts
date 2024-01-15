import { Module } from '@nestjs/common';
import { EcommercedataService } from './ecommercedata.service';
import { EcommercedataResolver } from './ecommercedata.resolver';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloFederationDriver, ApolloFederationDriverConfig } from '@nestjs/apollo';
import { ecommercedata } from './entities/ecommerce.entity';

@Module({
  imports:[
    TypeOrmModule.forRoot({
      type:'mongodb',
      url:'mongodb://localhost/mulyamapan',
      synchronize: true,
      entities:[
        ecommercedata
      ]
    }),
    TypeOrmModule.forFeature([ecommercedata]),
      GraphQLModule.forRoot<ApolloFederationDriverConfig>({
      driver: ApolloFederationDriver,
      autoSchemaFile:{
        federation:2
      }
    })
  ],
  providers: [EcommercedataResolver, EcommercedataService],
})
export class EcommercedataModule {}
