import { Injectable } from '@nestjs/common';
import { createECommerceDataInput } from './dto/create-ecommercedata.input';
import { updateECommerceDataInput } from './dto/update-ecommercedata.input';
import { InjectRepository } from '@nestjs/typeorm';
import { ecommercedata } from './entities/ecommerce.entity';
import { Repository } from 'typeorm';

@Injectable()
export class EcommercedataService {
  constructor(@InjectRepository(ecommercedata) private eCommercedataRepository: Repository<ecommercedata>) {}

  create(createECommerceDataInput: createECommerceDataInput) {
    let _newCategory = this.eCommercedataRepository.create(createECommerceDataInput);
    return this.eCommercedataRepository.save(_newCategory);
  }

  findAll() {
    return this.eCommercedataRepository.find();
  }

  findOne(id: string) {
    return this.eCommercedataRepository.findOneBy({id})
  }
/*
  update(id: string, updateECommerceDataInput: updateECommerceDataInput) {
    return `This action updates a #${id} eeommerceentity`;
  }

  remove(id: string) {
    return `This action removes a #${id} eeommerceentity`;
  }
*/  
}
