import { ObjectType, Field, Int, Directive, ID } from '@nestjs/graphql';
import { Column, Entity, ObjectIdColumn, PrimaryColumn } from 'typeorm';

@ObjectType()
@Entity({name: 'productsortby'})
@Directive('@key(fields: "id")')
export class ProductSortBy {
  @ObjectIdColumn()
  _id:string;

  @PrimaryColumn()
  @Field(() => ID)
  id:string;

  @Column()
  @Field()
  sortby: string; 

  @Column()
  @Field()
  sortbyField: string;

  @Column()
  @Field()
  sortOrder: string;
}

