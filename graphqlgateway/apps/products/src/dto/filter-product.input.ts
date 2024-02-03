import { InputType, Int, Field, ID } from '@nestjs/graphql';

@InputType()
export class FilterProductInput {
  @Field()
  subCategoryId: string;

  @Field({ nullable: true })
  priceFrom: number;

  @Field({ nullable: true })
  priceTo: number;

  @Field({ nullable: true })
  averageReview: number;  

  @Field({ nullable: true })
  cashOnDelivery: boolean;  
}
