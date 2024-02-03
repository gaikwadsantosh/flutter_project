import { Parent, ResolveField, Resolver } from "@nestjs/graphql";
import { Subcategory } from "./entities/subcategory.entity";
import { BudgetrangesService } from "./budgetranges.service";
import { Budgetrange } from "./entities/budgetrange.entity";

@Resolver(()=> Subcategory)
export class SubcategoriesResolver{
    constructor(private readonly budgetrangesService: BudgetrangesService){}

    @ResolveField(()=> [Budgetrange])
    budgetRanges(@Parent() subcategory: Subcategory) : Promise<Budgetrange[]>{
        console.warn("subcategories resolver in budgetrange service for subcategory id" + subcategory.id);
        return this.budgetrangesService.forSubCategory(subcategory.id);
    }
}