import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';

// Service Type Definition
export type User = {
  id: number;
  email: string;
  username: string;
  password: string;
  firstName?: string;
  lastName?: string;
  role?: string;
  isActive: boolean;
  lastLogin?: Date;
  createdAt: Date;
  updatedAt?: Date;
};

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async findOneById(id: number): Promise<User | null> {
    return (await this.prisma.users.findUnique({
      where: { id },
    })) as User | null;
  }
  async findOneByEmail(email: string): Promise<User | null> {
    return (await this.prisma.users.findUnique({
      where: { email },
    })) as User | null;
  }
}
