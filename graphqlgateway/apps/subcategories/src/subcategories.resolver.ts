import { Resolver, Query, Mutation, Args, Int, ResolveField, Parent, ResolveReference } from '@nestjs/graphql';
import { SubcategoriesService } from './subcategories.service';
import { Subcategory } from './entities/subcategory.entity';
import { CreateSubcategoryInput } from './dto/create-subcategory.input';
import { Category } from './entities/category.entity';

@Resolver(() => Subcategory)
export class SubcategoriesResolver {
  constructor(private readonly subcategoriesService: SubcategoriesService) {}

  @Mutation(() => Subcategory)
  createSubcategory(@Args('createSubcategoryInput') createSubcategoryInput: CreateSubcategoryInput) {
    return this.subcategoriesService.create(createSubcategoryInput);
  }

  @Query(() => [Subcategory], { name: 'subcategories' })
  findAll() {
    return this.subcategoriesService.findAll();
  }

  @Query(() => Subcategory, { name: 'subcategory' })
  findOne(@Args('id') id: string) {
    return this.subcategoriesService.findOne(id);
  }

  @ResolveField(() => Category)
  category(@Parent() subcategory: Subcategory): any {
    console.warn("resolve field category in subcategories service");
    return { __typename: 'Category', id: subcategory.categoryId};
  }

  @ResolveReference()
  resolveReference(reference: { __typename: string; id:string }) : Promise<Subcategory> {
    console.warn("resolvereference subcategory in subcategories service");
    return this.subcategoriesService.findOne(reference.id);
  }  
/*
  @Mutation(() => Subcategory)
  updateSubcategory(@Args('updateSubcategoryInput') updateSubcategoryInput: UpdateSubcategoryInput) {
    return this.subcategoriesService.update(updateSubcategoryInput.id, updateSubcategoryInput);
  }

  @Mutation(() => Subcategory)
  removeSubcategory(@Args('id') id: string) {
    return this.subcategoriesService.remove(id);
  }
*/
}
