import { Injectable } from '@nestjs/common';
import { CreateBudgetrangeInput } from './dto/create-budgetrange.input';
import { Budgetrange } from './entities/budgetrange.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class BudgetrangesService {
  constructor(@InjectRepository(Budgetrange) private budgetRangeRepository: Repository<Budgetrange>) {}
  
  create(createBudgetrangeInput: CreateBudgetrangeInput) {
    let _newBudgetrange = this.budgetRangeRepository.create(createBudgetrangeInput);
    return this.budgetRangeRepository.save(_newBudgetrange)
  }

  findAll() {
    return this.budgetRangeRepository.find();
  }

  findOne(id: string) {
    return this.budgetRangeRepository.findOneBy({id});
  }

  forSubCategory(subCategoryId: string) {
    console.warn("calling sub subcategories repository for subcategory id" + subCategoryId);
    return this.budgetRangeRepository.find({ where:{ 'subCategoryId': subCategoryId},});
  }

}
