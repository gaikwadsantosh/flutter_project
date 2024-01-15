import { Test, TestingModule } from '@nestjs/testing';
import { EcommercedataResolver } from './ecommercedata.resolver';
import { EcommercedataService } from './ecommercedata.service';

describe('EcommercedataResolver', () => {
  let resolver: EcommercedataResolver;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [EcommercedataResolver, EcommercedataService],
    }).compile();

    resolver = module.get<EcommercedataResolver>(EcommercedataResolver);
  });

  it('should be defined', () => {
    expect(resolver).toBeDefined();
  });
});
