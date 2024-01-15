import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateUserInput } from './dto/create-user.input';
import { UpdateUserInput } from './dto/update-user.input';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { FindOneOptions, Repository } from 'typeorm';

@Injectable()
export class UsersService {
  constructor(@InjectRepository(User) private userRepository: Repository<User>) {}

  create(createUserInput: CreateUserInput) {
    let _newUser =  this.userRepository.create(createUserInput);
    return this.userRepository.save(_newUser);
  }

  async update(email: string, updateUserDto: UpdateUserInput) {

    console.log(`searching for email : ${email}`);

    const user = await this.userRepository.findOne({
      where: { email: email.toLocaleLowerCase() }, 
      logging: true,
    } as FindOneOptions<User>);
    
    if (!user) {
      console.log("user not found");
      //throw new NotFoundException('User not found');
    }else{
      console.log(`uer found : ${user.id}`)
    }
    // Update the user with the provided data
    Object.assign(user, updateUserDto);
    // Save the updated user to the database
    await this.userRepository.save(user);
    console.log(`successfully updated`);
    return user;
    
  }



  findAll() {
    return this.userRepository.find();
  }

  findOne(id: string) {
    return this.userRepository.findOneBy({id})
  }

  signIn(email: string, password: string) {
    return this.userRepository.findOneBy({"email": email, "password": password})
  }

  /*
  update(id: number, updateUserInput: UpdateUserInput) {
    return `This action updates a #${id} user`;
  }

  remove(id: number) {
    return `This action removes a #${id} user`;
  }
*/  
}
