import { Resolver, Query, Mutation, Args, Int, ResolveField, Parent } from '@nestjs/graphql';
import { ProductsService } from './products.service';
import { ProductSortBy } from './entities/productsortby.entity';
import { ProductsSortByService } from './products.sortby.service';
import { log } from 'console';

@Resolver(() => ProductSortBy)
export class ProductsSortByResolver {
  constructor(private readonly productsSortByService: ProductsSortByService) {}

  @Query(() => [ProductSortBy], { name: 'productsSortBy' })
  productsSortBy() {
    log("esolver called");
    return this.productsSortByService.productsSortBy();
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
