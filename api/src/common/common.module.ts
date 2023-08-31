import { Global, Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { Agent } from 'https';
import { readFileSync } from 'fs';
import * as caAppend from 'ca-append';
import { CommonService } from 'src/common/services/common.service';
import { PaginationService } from 'src/common/services/pagination.service';

// https://blog.bossylobster.com/2021/05/node-ca-append.html - this is needed so https requests from api to accounts will work with letsencrypt certs
caAppend.monkeyPatch();

const agentOptions = {
  cert: readFileSync('certs/accounts.tls.crt'),
  key: readFileSync('certs/accounts.tls.key'),
  caAppend: readFileSync('certs/rootCA.crt'),
};

@Global()
@Module({
  imports: [
    HttpModule.register({
      // this is needed so api can access accounts service as https://accounts.appcket.{env_tld} which is what the token iss value must be when checking authorization from front end app
      httpsAgent: new Agent(agentOptions),
    }),
  ],
  exports: [CommonService, PaginationService, HttpModule],
  providers: [CommonService, PaginationService],
})
export class CommonModule {}
