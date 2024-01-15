import { createECommerceDataInput } from './create-ecommercedata.input';
import { InputType, Field, Int, PartialType } from '@nestjs/graphql';

@InputType()
export class updateECommerceDataInput extends PartialType(createECommerceDataInput) {
  @Field()
  id: string;
}
