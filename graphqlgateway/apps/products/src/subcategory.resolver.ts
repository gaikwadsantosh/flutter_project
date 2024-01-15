import { Parent, ResolveField, Resolver } from "@nestjs/graphql";
import { Subcategory } from "./entities/subcategory.entity";
import { ProductsService } from "./products.service";
import { Product } from "./entities/product.entity";

@Resolver(()=> Subcategory)
export class SubCategoryResolver{
    constructor(private readonly productsService: ProductsService){}

    @ResolveField(()=> [Product])
    products(@Parent() subcategory: Subcategory) : Promise<Product[]>{
        console.warn("resolve field in subcategory resolver for products");
        return this.productsService.forSubCategory(subcategory.id);
    }
}