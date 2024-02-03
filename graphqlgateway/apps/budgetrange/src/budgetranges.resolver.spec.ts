import { Test, TestingModule } from '@nestjs/testing';
import { BudgetrangesResolver } from './budgetranges.resolver';
import { BudgetrangesService } from './budgetranges.service';

describe('BudgetrangesResolver', () => {
  let resolver: BudgetrangesResolver;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [BudgetrangesResolver, BudgetrangesService],
    }).compile();

    resolver = module.get<BudgetrangesResolver>(BudgetrangesResolver);
  });

  it('should be defined', () => {
    expect(resolver).toBeDefined();
  });
});
