import { Resolver, Query, Mutation, Args, Int, ResolveField, Parent } from '@nestjs/graphql';
import { ProductsService } from './products.service';
import { Product } from './entities/product.entity';
import { CreateProductInput } from './dto/create-product.input';
import { UpdateProductInput } from './dto/update-product.input';
import { Subcategory } from './entities/subcategory.entity';
import { log } from 'console';
import { SortInput } from './entities/sortinput.model';
import { ProductSortBy } from './entities/productsortby.entity';
import { SortOrder } from './entities/sortorder.enum';
import { FilterProductInput } from './dto/filter-product.input';

@Resolver(() => Product)
export class ProductsResolver {
  constructor(
    private readonly productsService: ProductsService
    ) {}

  @Mutation(() => Product)
  createProduct(@Args('createProductInput') createProductInput: CreateProductInput) {
    return this.productsService.create(createProductInput);
  }

  @Query(() => [Product], { name: 'products' })
  findAll(
    @Args('sortBy', { nullable: true }) sortBy: SortInput, 
    @Args('filterBy', { nullable: true }) filterBy: FilterProductInput,
  ) {
    return this.productsService.findAll(sortBy, filterBy);
  }

  @Query(() => [Product], { name: 'productsByName' })
  productsByName(@Args('productName') productName: string) {
    return this.productsService.findByProductName(productName);
  }

  @Query(() => Product, { name: 'product' })
  findOne(@Args('id') id: string) {
    return this.productsService.findOne(id);
  }

  @ResolveField(() => Subcategory)
  subcategory(@Parent() product: Product): any {
    console.warn("ResolveField in product resolver for subcategory field");
    return { __typename: 'Subcategory', id: product.subCategoryId};
  }  

  @Query(() => [ProductSortBy], { name: 'productsSortBy' })
  productsSortBy() {
    log("esolver called");
    return this.productsService.productSortBy();
  }

  /*
  @Mutation(() => Product)
  updateProduct(@Args('updateProductInput') updateProductInput: UpdateProductInput) {
    return this.productsService.update(updateProductInput.id, updateProductInput);
  }

  @Mutation(() => Product)
  removeProduct(@Args('id', { type: () => Int }) id: number) {
    return this.productsService.remove(id);
  }
*/

}
