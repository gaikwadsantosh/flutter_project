import { NestFactory } from '@nestjs/core';
import { SubcategoriesModule } from './subcategories.module';

async function bootstrap() {
  const app = await NestFactory.create(SubcategoriesModule);
  await app.listen(3004);
}
bootstrap();
