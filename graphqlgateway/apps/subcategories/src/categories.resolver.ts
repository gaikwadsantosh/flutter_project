import { Parent, ResolveField, Resolver } from "@nestjs/graphql";
import { Category } from "./entities/category.entity";
import { Subcategory } from "./entities/subcategory.entity";
import { SubcategoriesService } from "./subcategories.service";

@Resolver(()=> Category)
export class CategoriesResolver{
    constructor(private readonly subcategoriesService: SubcategoriesService){}

    @ResolveField(()=> [Subcategory])
    subcategories(@Parent() category: Category) : Promise<Subcategory[]>{
        console.warn("categories resolver in subcategories service for category id" + category.id);
        return this.subcategoriesService.forCategory(category.id);
    }
}