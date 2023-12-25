import {
  Column,
  Entity,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { AuthorEntity } from './author.entity';

@Entity('topic')
export class TopicEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  description: string;

  @ManyToOne(() => AuthorEntity, (author) => author.topics)
  @JoinColumn({ name: 'authorId' }) // 외래키
  author: AuthorEntity;
}
