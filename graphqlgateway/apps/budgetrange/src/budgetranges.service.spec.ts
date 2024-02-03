import { Test, TestingModule } from '@nestjs/testing';
import { BudgetrangesService } from './budgetranges.service';

describe('BudgetrangesService', () => {
  let service: BudgetrangesService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [BudgetrangesService],
    }).compile();

    service = module.get<BudgetrangesService>(BudgetrangesService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
