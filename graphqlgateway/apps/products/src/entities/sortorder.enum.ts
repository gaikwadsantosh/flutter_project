import { registerEnumType } from '@nestjs/graphql';

// SortOrder.enum.ts
export enum SortOrder {
    ASC = 'ASC',
    DESC = 'DESC',
  }
  
  // Register the SortOrder enum with GraphQL
registerEnumType(SortOrder, {
    name: 'SortOrder',
  });
