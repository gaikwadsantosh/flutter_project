import { Directive, Field, ID, ObjectType } from '@nestjs/graphql';
import { Product } from './product.entity';

@ObjectType()
@Directive('@key(fields: "id")')
export class Subcategory {
  @Field(() => ID)
  id: string;

  @Field(() => [Product], { nullable: true })
  products?: Product[];

  
}
