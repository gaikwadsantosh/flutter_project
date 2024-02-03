import { NestFactory } from '@nestjs/core';
import { BudgetrangesModule } from './budgetranges.module';

async function bootstrap() {
  const app = await NestFactory.create(BudgetrangesModule);
  await app.listen(3008);
}
bootstrap();
