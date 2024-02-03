import { UrlWithStringQuery } from 'url';
import { CreateBudgetrangeInput } from './create-budgetrange.input';
import { InputType, Field, Int, PartialType } from '@nestjs/graphql';

@InputType()
export class UpdateBudgetrangeInput extends PartialType(CreateBudgetrangeInput) {
  @Field(() => String)
  id: string;
}
