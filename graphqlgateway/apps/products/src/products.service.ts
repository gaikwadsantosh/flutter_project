import { Injectable } from '@nestjs/common';
import { CreateProductInput } from './dto/create-product.input';
import { UpdateProductInput } from './dto/update-product.input';
import { InjectRepository } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { MongoRepository } from 'typeorm';

@Injectable()
export class ProductsService {
  constructor(@InjectRepository(Product) private productRepository: MongoRepository<Product>) {}

  create(createProductInput: CreateProductInput) {
    let _newProduct =  this.productRepository.create(createProductInput);
    return this.productRepository.save(_newProduct);
  }

  findAll() {
    return this.productRepository.find();
  }

  async findByProductName(productName : string) : Promise<Product[]> {
    const products = this.productRepository.find({
      where: {
        productName: {
          $regex: new RegExp(productName, 'i'),
        },
      },
    });

    return products || [];     
  }

  findOne(id: string) {
    return this.productRepository.findOneBy({id});
  }

  forSubCategory(subCategoryId: string) {
    return this.productRepository.find({ where:{ 'subCategoryId': subCategoryId},});
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
