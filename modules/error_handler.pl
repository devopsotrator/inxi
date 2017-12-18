#!/usr/bin/env perl
## File: error_handler.pl
## Version: 1.4
## Date 2017-12-18
## License: GNU GPL v3 or greater
## Copyright (C) 2017 Harald Hope

## INXI INFO ##
my $self_name='pinxi';
my $self_version='2.9.00';
my $self_date='2017-12-11';
my $self_patch='022-p';

use strict;
use warnings;
# use diagnostics;
use 5.008;

## NOTE: Includes dummy sub and variables to allow for running for debugging.

sub print_screen_line {
	my $line = shift;
	
	print "$line\n";
}

## start actual code

sub error_handler {
	my ( $err, $one, $two) = @_;
	my $errno = 0;
	my $b_help = 0;
	my $message = do {
		if ( $err eq 'empty' ) { 'empty value' }
		## Basic rules
		elsif ( 
			$err eq 'not-in-irc' ) { $errno=1; "You can't run option $one in an IRC client!" }
		## Internal/external options
		elsif ( $err eq 'bad-arg' ) { 
			$errno=10; $b_help=1; "Unsupported value: $two for option: $one" }
		elsif ( $err eq 'bad-arg-int' ) { 
			$errno=11; "Bad internal argument: $one" }
		elsif ( $err eq 'distro-block' ) { 
			$errno=20; "Option: $one has been disabled by the $self_name distribution maintainer." }
		elsif ( $err eq 'unknown-option' ) { 
			$errno=21; $b_help=1; "Unsupported option: $one" }
		## Files:
		elsif ( $err eq 'copy-failed' ) { 
			$errno=30; "Error copying file: $one \nError: $two" }
		elsif ( $err eq 'downloader-error' ) { 
			$errno=30; "Error downloading file: $one \nfor download source: $two" }
		elsif ( $err eq 'file-corrupt' ) { 
			$errno=31; "Downloaded file is corrupted: $one" }
		elsif ( $err eq 'mkdir' ) { 
			$errno=32; "Error creating directory: $one \nError: $two" }
		elsif ( $err eq 'open' ) { 
			$errno=32; "Error opening file: $one \nError: $two" }
		elsif ( $err eq 'not-writable' ) { 
			$errno=33; "The file: $one is not writable!" }
		elsif ( $err eq 'open-dir-failed' ) { 
			$errno=33; "The directory: $one failed to open with error: $two" }
		elsif ( $err eq 'remove' ) { 
			$errno=33; "Failed to remove file: $one Error: $two" }
		elsif ( $err eq 'rename' ) { 
			$errno=34; "There was an error moving files: $one\nError: $two" }
		elsif ( $err eq 'write-error' ) { 
			$errno=35; "Failed writing file: $one - Error: $two!" }
		## FTP
		elsif ( $err eq 'ftp-bad-path' ) { 
			$errno=50; "Unable to locate for FTP upload file:\n$one" }
		elsif ( $err eq 'ftp-login' ) { 
			$errno=50; "There was an error with login to ftp server: $one" }
		elsif ( $err eq 'ftp-login' ) { 
			$errno=51; "There was an error with upload to ftp server: $one" }
		## DEFAULT
		else {
			$errno=255; "Error handler ERROR!! Unsupported options: $err!"}
	};
	print_screen_line("Error $errno: $message\n");
	if ($b_help){
		print_screen_line("Check -h for correct parameters.\n");
	}
	exit 0;
}

error_handler('rename', 'file1 -> file2', 17);
