import { Resolver, Query, Mutation, Args, Int } from '@nestjs/graphql';
import { EcommercedataService } from './ecommercedata.service';
import { ecommercedata } from './entities/ecommerce.entity';
import { createECommerceDataInput } from './dto/create-ecommercedata.input';
import { updateECommerceDataInput } from './dto/update-ecommercedata.input';

@Resolver(() => ecommercedata)
export class EcommercedataResolver {
  constructor(private readonly ecommercedataService: EcommercedataService) {}

  @Mutation(() => ecommercedata)
  createECommerceData(@Args('createECommerceDataInput') createECommerceDataInput: createECommerceDataInput) {
    return this.ecommercedataService.create(createECommerceDataInput);
  }

  @Query(() => [ecommercedata], { name: 'allecommercedata' })
  findAll() {
    return this.ecommercedataService.findAll();
  }

  @Query(() => ecommercedata, { name: 'ecommercedata' })
  findOne(@Args('id') id: string) {
    return this.ecommercedataService.findOne(id);
  }

 /* 
  @Mutation(() => ecommercedata)
  UpdateECommerceData(@Args('updateECommerceDataInput') updateECommerceDataInput: updateECommerceDataInput) {
    return this.ecommercedataService.update(updateECommerceDataInput.id, updateECommerceDataInput);
  }

  @Mutation(() => ecommercedata)
  RemoveECommerceData(@Args('id') id: string) {
    return this.ecommercedataService.remove(id);
  }
*/ 
}
