import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('topic')
export class TopicEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    length: 30,
  })
  title: string;

  @Column({
    type: 'text',
  })
  description: string;

  @CreateDateColumn()
  createdAt: Date;
}
