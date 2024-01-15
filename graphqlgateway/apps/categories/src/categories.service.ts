import { Injectable } from '@nestjs/common';
import { CreateCategoryInput } from './dto/create-category.input';
import { UpdateCategoryInput } from './dto/update-category.input';
import { InjectRepository } from '@nestjs/typeorm';
import { Category } from './entities/category.entity';
import { Repository } from 'typeorm';

@Injectable()
export class CategoriesService {
  constructor(@InjectRepository(Category) private categoryRepository: Repository<Category>) {}

  create(createCategoryInput: CreateCategoryInput) {
    let _newCategory = this.categoryRepository.create(createCategoryInput);
    return this.categoryRepository.save(_newCategory)
  }

  async findAll() : Promise<Category[]> {
    return this.categoryRepository.find();
  }

  async findOne(id: string) : Promise<Category> {
    return this.categoryRepository.findOneBy({id});
  }

/*
  update(id: string, updateCategoryInput: UpdateCategoryInput) {
    return `This action updates a #${id} category`;
  }

  remove(id: string) {
    return `This action removes a #${id} category`;
  }
*/
}
