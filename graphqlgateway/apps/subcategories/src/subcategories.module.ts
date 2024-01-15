import { Module } from '@nestjs/common';
import { SubcategoriesService } from './subcategories.service';
import { SubcategoriesResolver } from './subcategories.resolver';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloFederationDriver, ApolloFederationDriverConfig } from '@nestjs/apollo';
import {TypeOrmModule} from '@nestjs/typeorm';
import { Subcategory } from './entities/subcategory.entity';
import { CategoriesResolver } from './categories.resolver';

@Module({
  imports:[
    TypeOrmModule.forRoot({
      type:'mongodb',
      url:'mongodb://localhost/mulyamapan',
      synchronize: true,
      entities:[
        Subcategory
      ]
    }),
    TypeOrmModule.forFeature([Subcategory]),
      GraphQLModule.forRoot<ApolloFederationDriverConfig>({
      driver: ApolloFederationDriver,
      autoSchemaFile:{
        federation:2
      }
    })
  ],
  providers: [SubcategoriesResolver, SubcategoriesService, CategoriesResolver],
})
export class SubcategoriesModule {}
