import { Global, Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { CommonService } from 'src/common/services/common.service';

@Global()
@Module({
  imports: [HttpModule],
  exports: [CommonService, HttpModule],
  providers: [CommonService],
})
export class CommonModule {}
