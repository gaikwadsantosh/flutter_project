import { InputType, Int, Field, ID } from '@nestjs/graphql';

@InputType()
export class CreateSubcategoryInput {
  @Field(() => ID)
  id:string;

  @Field()
  subcategoryName: string;

  @Field()  
  subcategoryDescription: string;

  @Field()
  categoryId: string;
}
