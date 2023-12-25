import { Column, Entity, OneToOne, PrimaryGeneratedColumn } from 'typeorm';
import { AuthorEntity } from './author.entity';

@Entity('profile')
export class ProfileEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  title: string;

  @Column()
  description: string;

  @OneToOne(() => AuthorEntity, (author) => author.profile)
  author: AuthorEntity;
}
