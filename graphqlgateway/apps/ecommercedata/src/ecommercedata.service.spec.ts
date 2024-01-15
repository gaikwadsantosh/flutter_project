import { Test, TestingModule } from '@nestjs/testing';
import { EcommercedataService } from './ecommercedata.service';

describe('EcommercedataService', () => {
  let service: EcommercedataService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [EcommercedataService],
    }).compile();

    service = module.get<EcommercedataService>(EcommercedataService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
