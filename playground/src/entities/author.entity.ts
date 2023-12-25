import {
  Column,
  Entity,
  JoinColumn,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { TopicEntity } from './topic.entity';
import { ProfileEntity } from './profile.entity';

@Entity('author')
export class AuthorEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  name: string;

  @Column()
  city: string;

  @OneToMany(() => TopicEntity, (topic) => topic.author)
  topics: TopicEntity[];

  @OneToOne(() => ProfileEntity, (profile) => profile.author)
  @JoinColumn()
  profile: ProfileEntity;
}
