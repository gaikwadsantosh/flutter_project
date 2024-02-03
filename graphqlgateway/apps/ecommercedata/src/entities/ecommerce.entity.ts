import { ObjectType, Field, Int, Directive, ID } from '@nestjs/graphql';
import { Column, Entity, ObjectIdColumn, PrimaryColumn } from 'typeorm';

@Entity()
@ObjectType()
@Directive('@key(fields: "id")')
export class ecommercedata {
  @ObjectIdColumn()
  _id:string;

  @PrimaryColumn()
  @Field(() => ID)
  id:string;

  @Column()
  @Field()
  categoryName:string;
  
  @Column()
  @Field()
  subCategoryName:string;

  @Column()
  @Field()
  productTitle:string;

  @Column()
  @Field()
  productUrl:string;

  @Column()
  @Field()
  imageUrl:string;

  @Column()
  @Field({ nullable: true })
  priceDiscount:string;

  @Column()
  @Field({ nullable: true })
  dealMessage:string;

  @Column()
  @Field()
  eCommerceSite:string;

  @Column()
  @Field({ nullable: true })
  featured: boolean;

  @Column()
  @Field({ nullable: true })
  price: number;

  @Column()
  @Field({ nullable: true })
  newArrivals: boolean;

  @Column()
  @Field({ nullable: true })
  averageReview: number;
  
}