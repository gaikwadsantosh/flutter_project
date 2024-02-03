import { InputType, Int, Field, ID } from '@nestjs/graphql';
import { Double } from 'typeorm';

@InputType()
export class CreateBudgetrangeInput {
  @Field((type) => ID)
  id: string;

  @Field()
  subCategoryId: string;

  @Field({ nullable: true })
  fromRange: number  

  @Field({ nullable: true })
  toRange: number  
}
