import { Directive, Field, ID, ObjectType } from '@nestjs/graphql';
import { Subcategory } from './subcategory.entity';

@ObjectType()
@Directive('@key(fields: "id")')
export class Category {
  @Field(() => ID)
  id: string;

  @Field(() => [Subcategory], { nullable: true })
  subcategories?: Subcategory[];
}
