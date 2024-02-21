import { Injectable } from '@nestjs/common';
import { CreateProductInput } from './dto/create-product.input';
import { UpdateProductInput } from './dto/update-product.input';
import { InjectRepository } from '@nestjs/typeorm';
import { MongoRepository } from 'typeorm';
import { ProductSortBy } from './entities/productsortby.entity';
import { log } from 'console';

@Injectable()
export class ProductsSortByService {
  constructor(
    @InjectRepository(ProductSortBy) private productSortByRepository: MongoRepository<ProductSortBy>,
    ) {}
        
  async productsSortBy() {
    log('Service called');
    const result = await this.productSortByRepository.find();
    log('MongoDB Query Result:', result);
    return result;
  }

/*
  update(id: number, updateProductInput: UpdateProductInput) {
    return `This action updates a #${id} product`;
  }

  remove(id: number) {
    return `This action removes a #${id} product`;
  }
*/  
}
