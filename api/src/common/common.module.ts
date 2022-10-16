import { Global, Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { Agent } from 'https';
import { readFileSync } from 'fs';

import { CommonService } from 'src/common/services/common.service';

@Global()
@Module({
  imports: [
    HttpModule.register({
      // this is needed so api can access accounts service as https://accounts.appcket.{env_tld} which is what the token iss value must be when checking authorization from front end app
      httpsAgent: new Agent({
        cert: readFileSync('certs/accounts.tls.crt'),
        key: readFileSync('certs/accounts.tls.key'),
        ca: readFileSync('certs/rootCA.crt'),
      }),
    }),
  ],
  exports: [CommonService, HttpModule],
  providers: [CommonService],
})
export class CommonModule {}
