import { Injectable } from '@nestjs/common';
import { CreateProductInput } from './dto/create-product.input';
import { UpdateProductInput } from './dto/update-product.input';
import { InjectRepository,  } from '@nestjs/typeorm';
import { Product } from './entities/product.entity';
import { FindManyOptions, MongoRepository, FindOperator, LessThanOrEqual, MoreThanOrEqual } from 'typeorm';
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


    if (filterBy) {
      if (filterBy.priceFrom) {

      }
    }

    const where: any = {};
    const order: any = {};
    // Add filter criteria dynamically
    if (filterBy.priceFrom !== undefined) {
      where.price = { $gte: filterBy.priceFrom };
    }

    if (filterBy.priceTo !== undefined) {
      where.price = { ...where.price, $lte: filterBy.priceTo };
    }

    if (filterBy.subCategoryId !== undefined) {
      where.subCategoryId = filterBy.subCategoryId;
    }

    if (filterBy.averageReview !== undefined) {
      where.averageReview = {$gte: filterBy.averageReview};
    }

    if (filterBy.payOnDelivery !== undefined) {
      where.cashOnDelivery = filterBy.payOnDelivery;
    }

    if (filterBy.featured !== undefined) {
      where.featured = filterBy.featured;
    }
    if (filterBy.newArrivals !== undefined) {
      where.newArrivals = filterBy.newArrivals;
    }
    if (filterBy.productNameSearchTerm !== undefined) {
      where.productName = {
        $regex: filterBy.productNameSearchTerm,
        $options: 'i', // Case-insensitive
      };      
    }
    
    // Add sorting criteria dynamically
    if (sortBy.sortbyField !== undefined) {
      order[sortBy.sortbyField] = sortBy.AscDesc; // e.g., order['price'] = 'ASC' or 'DESC'
    }

    console.log("querying product");
    return this.productRepository.find( {
      where, 
      order
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
