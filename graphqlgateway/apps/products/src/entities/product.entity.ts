import { ObjectType, Field, Int, Directive, ID } from '@nestjs/graphql';
import { Column, Entity, ObjectIdColumn, PrimaryColumn } from 'typeorm';
import { Subcategory } from './subcategory.entity';

@ObjectType()
@Entity()
@Directive('@key(fields: "id")')
export class Product {
  @ObjectIdColumn()
  _id:string;

  @PrimaryColumn()
  @Field(() => ID)
  id:string;

  @Column()
  @Field()
  productName: string;

  @Column()
  @Field({ nullable: true })
  ProductUrl: string;

  @Column()
  @Field({ nullable: true })
  ImageUrl: string;

  @Column()
  @Field({ nullable: true })
  PriceDiscount: string;

  @Column()
  @Field({ nullable: true })
  DealMessage: string;

  @Column()
  @Field({ nullable: true })
  subCategoryId: string;

  @Field(() => Subcategory, { nullable: true })
  subcategory?: Subcategory;
 
}