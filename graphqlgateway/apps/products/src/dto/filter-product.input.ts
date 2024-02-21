import { InputType, Int, Field, ID } from '@nestjs/graphql';
import { Column, Double } from 'typeorm';

@InputType()
export class FilterProductInput {
  @Field({ nullable: true })
  subCategoryId: string;

  @Field({ nullable: true })
  priceFrom: number;

  @Field({ nullable: true })
  priceTo: number;

  @Field({ nullable: true })
  averageReview: number;  

  @Field({ nullable: true })
  payOnDelivery: boolean;  

  @Field({ nullable: true })
  newArrivals: boolean;  
  
  @Field({ nullable: true })
  featured: boolean;  

  @Field({ nullable: true })
  productNameSearchTerm: string;  
}
