import { InputType, Int, Field, ID } from '@nestjs/graphql';

@InputType()
export class CreateProductInput {
  @Field((type) => ID)
  id: string;

  @Field()
  productName: string;

  @Field()
  ProductUrl: string;

  @Field()
  ImageUrl: string;

  @Field()
  PriceDiscount: string;

  @Field()
  DealMessage: string;

  @Field()
  subCategoryId: string;
}
