import { Module } from '@nestjs/common';
import { BudgetrangesService } from './budgetranges.service';
import { BudgetrangesResolver } from './budgetranges.resolver';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Budgetrange } from './entities/budgetrange.entity';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloFederationDriver, ApolloFederationDriverConfig } from '@nestjs/apollo';
import { SubcategoriesResolver } from './subcategories.resolver';

@Module({
  imports:[
    TypeOrmModule.forRoot({
      type:'mongodb',
      url:'mongodb://localhost/mulyamapan',
      synchronize: true,
      entities:[
        Budgetrange
      ]
    }),
    TypeOrmModule.forFeature([Budgetrange]),
    GraphQLModule.forRoot<ApolloFederationDriverConfig>({
      driver: ApolloFederationDriver,
      autoSchemaFile:{
        federation:2
      }
  })
  ],
  providers: [BudgetrangesResolver, BudgetrangesService, SubcategoriesResolver],
})
export class BudgetrangesModule {}
