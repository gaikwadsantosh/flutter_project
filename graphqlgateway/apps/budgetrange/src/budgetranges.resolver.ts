import { Resolver, Query, Mutation, Args, Int, ResolveReference, ResolveField, Parent } from '@nestjs/graphql';
import { BudgetrangesService } from './budgetranges.service';
import { Budgetrange } from './entities/budgetrange.entity';
import { CreateBudgetrangeInput } from './dto/create-budgetrange.input';
import { UpdateBudgetrangeInput } from './dto/update-budgetrange.input';
import { Subcategory } from './entities/subcategory.entity';

@Resolver(() => Budgetrange)
export class BudgetrangesResolver {
  constructor(private readonly budgetrangesService: BudgetrangesService) {}

  @Mutation(() => Budgetrange)
  createBudgetrange(@Args('createBudgetrangeInput') createBudgetrangeInput: CreateBudgetrangeInput) {
    return this.budgetrangesService.create(createBudgetrangeInput);
  }

  @Query(() => [Budgetrange], { name: 'budgetranges' })
  findAll() {
    return this.budgetrangesService.findAll();
  }

  @Query(() => Budgetrange, { name: 'budgetrange' })
  findOne(@Args('id', { type: () => String }) id: string) {
    return this.budgetrangesService.findOne(id);
  }

  @ResolveField(() => Subcategory)
  subCategory(@Parent() budgetrange: Budgetrange): any {
    console.warn("resolve field subCategory in budgetranges service");
    return { __typename: 'SubCategory', id: budgetrange.subCategoryId};
  }

  @ResolveReference()
  resolveReference(reference: { __typename: string; id:string }) : Promise<Budgetrange> {
    console.warn("resolvereference BudgetRange in BudgetRanges service");
    return this.budgetrangesService.findOne(reference.id);
  }  

  
/*
  @Mutation(() => Budgetrange)
  updateBudgetrange(@Args('updateBudgetrangeInput') updateBudgetrangeInput: UpdateBudgetrangeInput) {
    return this.budgetrangesService.update(updateBudgetrangeInput.id, updateBudgetrangeInput);
  }

  @Mutation(() => Budgetrange)
  removeBudgetrange(@Args('id', { type: () => Int }) id: number) {
    return this.budgetrangesService.remove(id);
  }
*/
}
