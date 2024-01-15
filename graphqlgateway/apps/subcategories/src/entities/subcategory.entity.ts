import { Directive, Field, ID, ObjectType } from '@nestjs/graphql';
import {Column, ObjectIdColumn, Entity, PrimaryColumn} from 'typeorm';
import { Category } from './category.entity';

@Entity()
@ObjectType()
@Directive('@key(fields: "id")')
export class Subcategory {
  @ObjectIdColumn()
  _id:string;

  @PrimaryColumn()
  @Field(() => ID)
  id:string;

  @Column()
  @Field()
  subcategoryName: string;

  @Column({ nullable: true })
  @Field()  
  subcategoryDescription: string;

  @Column()
  @Field()
  categoryId: string;

  @Field(() => Category, { nullable: true })
  category?: Category;  
}