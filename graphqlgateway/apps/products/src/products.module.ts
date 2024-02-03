import { Module } from '@nestjs/common';
import { ProductsService } from './products.service';
import { ProductsResolver } from './products.resolver';
import { SubCategoryResolver } from './subcategory.resolver';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { GraphQLModule } from '@nestjs/graphql';
import { ApolloFederationDriver, ApolloFederationDriverConfig } from '@nestjs/apollo';
import { ProductSortBy } from './entities/productsortby.entity';

@Module({
  imports:[
    TypeOrmModule.forRoot({
      type:'mongodb',
      url:'mongodb://localhost/mulyamapan',
      synchronize: true,
      entities:[
        Product,
        ProductSortBy
      ]
    }),
    TypeOrmModule.forFeature([Product]),
    TypeOrmModule.forFeature([ProductSortBy]),
      GraphQLModule.forRoot<ApolloFederationDriverConfig>({
      driver: ApolloFederationDriver,
      autoSchemaFile:{
        federation:2
      }
    })
  ],
  providers: [ProductsResolver, ProductsService, SubCategoryResolver],
})
export class ProductsModule {}
