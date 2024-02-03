import { InputType, Field, Int } from '@nestjs/graphql';
import {SortOrder} from './sortorder.enum'

  
@InputType()
export class SortInput {
  @Field()
  sortbyField: string;

  @Field((type) => SortOrder, {nullable:true, defaultValue: SortOrder.ASC})
  AscDesc?: SortOrder;
}

