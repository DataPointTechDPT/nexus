import { Controller, Get, Request, Post, UseGuards } from '@nestjs/common';
import { AppService } from './app.service';
import { AuthGuard } from '@nestjs/passport';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}
  @UseGuards(AuthGuard('local'))
  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
  @Post('auth/login')
  login(@Request() req) {
    console.log("123");
    return req.user;
  }
}
