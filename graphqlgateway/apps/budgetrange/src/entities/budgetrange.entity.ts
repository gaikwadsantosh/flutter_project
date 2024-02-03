import { ObjectType, Field, Int, Directive, ID } from '@nestjs/graphql';
import { Column, Decimal128, Double, Entity, ObjectIdColumn, PrimaryColumn } from 'typeorm';
import { Subcategory } from './subcategory.entity';

@Entity()
@ObjectType()
@Directive('@key(fields: "id")')
export class Budgetrange {
  @ObjectIdColumn()
  _id:string;

  @PrimaryColumn()
  @Field(() => ID)
  id:string;

  @Column()
  @Field()
  subCategoryId: string;

  @Column({ nullable: true })
  @Field({ nullable: true })  
  fromRange: number;

  @Column({ nullable: true })
  @Field({ nullable: true })  
  toRange: number;

  @Field(() => Subcategory, { nullable: true })
  subCategory?: Subcategory;  
}
