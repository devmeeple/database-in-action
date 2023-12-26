import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthorEntity } from './entities/author.entity';
import { TopicEntity } from './entities/topic.entity';
import { CommentEntity } from './entities/comment.entity';
import { DormantEntity } from './entities/dormant.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      AuthorEntity,
      TopicEntity,
      CommentEntity,
      DormantEntity,
    ]),
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 3306,
      username: 'test',
      password: 'test',
      database: 'test',
      entities: [AuthorEntity, TopicEntity, CommentEntity, DormantEntity],
      synchronize: true,
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
