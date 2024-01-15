import { InputType, Int, Field, ID } from '@nestjs/graphql';

@InputType()
export class createECommerceDataInput {
  @Field((type) => ID)
  id:string;

  @Field()
  categoryName:string;
  
  @Field()
  subCategoryName:string;

  @Field()
  productTitle:string;

  @Field()
  productUrl:string;

  @Field()
  imageUrl:string;

  @Field({ nullable: true })
  priceDiscount:string;

  @Field({ nullable: true })
  dealMessage:string;

  @Field()
  eCommerceSite:string;

}
