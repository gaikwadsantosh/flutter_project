import { Directive, Field, ID, ObjectType } from '@nestjs/graphql';
import { Budgetrange } from './budgetrange.entity';

@ObjectType()
@Directive('@key(fields: "id")')
export class Subcategory {
  @Field(() => ID)
  id: string;

  @Field(() => [Budgetrange], { nullable: true })
  budgetRanges?: Budgetrange[];
}
