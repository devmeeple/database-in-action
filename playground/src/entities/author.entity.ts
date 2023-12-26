import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('author')
export class AuthorEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    length: 15,
  })
  name: string;

  @Column({
    length: 100,
  })
  profile: string;

  @CreateDateColumn()
  createdAt: Date;
}
