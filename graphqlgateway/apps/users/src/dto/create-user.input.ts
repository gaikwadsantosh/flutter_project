import { InputType, Int, Field, ID } from '@nestjs/graphql';

@InputType()
export class CreateUserInput {
  @Field(() => ID)
  id:string;

  @Field({ nullable: true })
  email: string;

  @Field()
  password: string;

  @Field()
  fullName: string;
 
  @Field({ nullable: true })
  address: string;

  @Field({ nullable: true })
  city: string;

  @Field({ nullable: true })
  state: string;
  
  @Field({ nullable: true })
  phoneNumber: string;
}
