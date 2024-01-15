import { Directive, Field, ID, ObjectType } from '@nestjs/graphql';
import {Column, ObjectIdColumn, Entity, PrimaryColumn} from 'typeorm';

@Entity()
@ObjectType()
@Directive('@key(fields: "id")')
export class Category {
  @ObjectIdColumn()
  _id:string;

  @PrimaryColumn()
  @Field(() => ID)
  id:string;

  @Column()
  @Field()
  categoryName: string;

  @Column({ nullable: true })
  @Field({ nullable: true })  
  categoryDescription?: string;
}