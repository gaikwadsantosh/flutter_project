import { Injectable } from '@nestjs/common';
import { CreateSubcategoryInput } from './dto/create-subcategory.input';
import { UpdateSubcategoryInput } from './dto/update-subcategory.input';
import { InjectRepository } from '@nestjs/typeorm';
import { Subcategory } from './entities/subcategory.entity';
import { Repository } from 'typeorm';

@Injectable()
export class SubcategoriesService {
  constructor(@InjectRepository(Subcategory) private subcategoryRepository: Repository<Subcategory>) {}

  create(createSubcategoryInput: CreateSubcategoryInput) {
    let _newSubcategory = this.subcategoryRepository.create(createSubcategoryInput);
    return this.subcategoryRepository.save(_newSubcategory);  
  }

  findAll() : Promise<Subcategory[]> {
    return this.subcategoryRepository.find();
  }

  findOne(id: string) : Promise<Subcategory> {
    return this.subcategoryRepository.findOneBy({id});
  }

  forCategory(categoryId: string) {
    console.warn("calling sub categories repository for category id" + categoryId);
    return this.subcategoryRepository.find({ where:{ 'categoryId': categoryId},});
  }
  /*
  update(id: string, updateSubcategoryInput: UpdateSubcategoryInput) {
    return `This action updates a #${id} subcategory`;
  }

  remove(id: string) {
    return `This action removes a #${id} subcategory`;
  }
  */
}
