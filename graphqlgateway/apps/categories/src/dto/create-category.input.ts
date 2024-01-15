import { InputType, Field, ID } from '@nestjs/graphql';

@InputType()
export class CreateCategoryInput {
  @Field((type) => ID)
  id: string;

  @Field()
  categoryName: string;

  @Field({ nullable: true })
  categoryDescription: string
}
