import {
  CreateDateColumn,
  Entity,
  JoinColumn,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { AuthorEntity } from './author.entity';

/**
 * 휴먼 사용자를 저장하는 엔티티
 */
@Entity('dormant')
export class DormantEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @OneToOne(() => AuthorEntity)
  @JoinColumn({ name: 'author_id' })
  authorId: AuthorEntity;

  @CreateDateColumn()
  createdAt: Date;
}
