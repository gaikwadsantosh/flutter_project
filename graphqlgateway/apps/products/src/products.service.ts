import { Injectable } from '@nestjs/common';
import { CreateProductInput } from './dto/create-product.input';
import { UpdateProductInput } from './dto/update-product.input';
import { InjectRepository } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { MongoRepository } from 'typeorm';
import { ProductSortBy } from './entities/productsortby.entity';
import { SortInput } from './entities/sortinput.model';
import { SortOrder } from './entities/sortorder.enum';
import { FilterProductInput } from './dto/filter-product.input';

@Injectable()
export class ProductsService {
  constructor(
    @InjectRepository(Product) private productRepository: MongoRepository<Product>,
    @InjectRepository(ProductSortBy) private productSortByRepository: MongoRepository<ProductSortBy>,
    ) {}

  create(createProductInput: CreateProductInput) {
    let _newProduct =  this.productRepository.create(createProductInput);
    return this.productRepository.save(_newProduct);
  }

  findAll(sortBy: SortInput, filterBy: FilterProductInput) {
    const sortOrder = sortBy?.AscDesc || SortOrder.ASC;
    sortBy.AscDesc = sortOrder;

    const where: FindConditions<Product> = {};

    if (filterBy) {
      if (filterBy.subCategoryId) {
        where.subCategoryId = filterBy.subCategoryId;
      }
  
      if (filterBy.priceFrom !== undefined) {
        where.price >= filterBy.priceFrom;
      }
  
      if (filterBy.priceTo !== undefined) {
        where.price <= filterBy.priceTo;
      }
  
      if (filterBy.averageReview !== undefined) {
        where.averageReview = filterBy.averageReview;
      }
  
      if (filterBy.cashOnDelivery !== undefined) {
        where.cashOnDelivery = filterBy.cashOnDelivery;
      }
    }
  
    return this.productRepository.find({
      order: { [sortBy.sortbyField]: sortBy.AscDesc },
      where: where
    });
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

  productSortBy() {
    return this.productSortByRepository.find();
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
