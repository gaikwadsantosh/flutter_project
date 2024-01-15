import { NestFactory } from '@nestjs/core';
import { EcommercedataModule } from './ecommercedata.module';

async function bootstrap() {
  const app = await NestFactory.create(EcommercedataModule);
  await app.listen(3006);
}
bootstrap();
