-- Add decks, flashcards, study_sessions, flashcard_results to match current schema
CREATE TABLE IF NOT EXISTS `decks` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` integer NOT NULL,
	`title` text NOT NULL,
	`description` text,
	`color` text DEFAULT '#3B82F6' NOT NULL,
	`is_public` integer DEFAULT false NOT NULL,
	`tags` text DEFAULT '[]' NOT NULL,
	`study_material` text,
	`total_cards` integer DEFAULT 0 NOT NULL,
	`last_studied` integer,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE no action ON DELETE cascade
);
---> statement-breakpoint
CREATE TABLE IF NOT EXISTS `flashcards` (
	`id` text PRIMARY KEY NOT NULL,
	`deck_id` text NOT NULL,
	`question` text NOT NULL,
	`answer` text NOT NULL,
	`difficulty` text DEFAULT 'medium' NOT NULL,
	`topic` text NOT NULL,
	`hints` text DEFAULT '[]',
	`explanation` text,
	`tags` text DEFAULT '[]' NOT NULL,
	`correct_count` integer DEFAULT 0 NOT NULL,
	`incorrect_count` integer DEFAULT 0 NOT NULL,
	`last_reviewed` integer,
	`next_review` integer,
	`order` integer DEFAULT 0 NOT NULL,
	`created_at` integer NOT NULL,
	`updated_at` integer NOT NULL,
	FOREIGN KEY (`deck_id`) REFERENCES `decks`(`id`) ON UPDATE no action ON DELETE cascade
);
---> statement-breakpoint
CREATE TABLE IF NOT EXISTS `study_sessions` (
	`id` text PRIMARY KEY NOT NULL,
	`user_id` integer NOT NULL,
	`deck_id` text NOT NULL,
	`start_time` integer NOT NULL,
	`end_time` integer,
	`total_cards` integer DEFAULT 0 NOT NULL,
	`correct_answers` integer DEFAULT 0 NOT NULL,
	`incorrect_answers` integer DEFAULT 0 NOT NULL,
	`partial_answers` integer DEFAULT 0 NOT NULL,
	`session_type` text DEFAULT 'study' NOT NULL,
	`time_spent` integer DEFAULT 0 NOT NULL,
	`completed` integer DEFAULT false NOT NULL,
	`created_at` integer NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`deck_id`) REFERENCES `decks`(`id`) ON UPDATE no action ON DELETE cascade
);
---> statement-breakpoint
CREATE TABLE IF NOT EXISTS `flashcard_results` (
	`id` text PRIMARY KEY NOT NULL,
	`session_id` text NOT NULL,
	`flashcard_id` text NOT NULL,
	`result` text NOT NULL,
	`time_to_answer` integer DEFAULT 0 NOT NULL,
	`reviewed_at` integer NOT NULL,
	FOREIGN KEY (`session_id`) REFERENCES `study_sessions`(`id`) ON UPDATE no action ON DELETE cascade,
	FOREIGN KEY (`flashcard_id`) REFERENCES `flashcards`(`id`) ON UPDATE no action ON DELETE cascade
);
