unit module Text::Caesar;

my constant @alphabet = 'A' .. 'Z';
# [A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]

class Caesar {
    has Int $.key;
    submethod BUILD(:$!key) {
        die 'The key must be between 1 and 25.' unless 1 <= $!key <= 25;
    }
}

class Message is Caesar {
    has Str $.text;
    method encrypt() {
        ($.text).uc.trans(@alphabet Z=> @alphabet.rotate($.key));
    }
}

class Secret is Caesar {
    has Str $.text;
    method decrypt() {
        $.text.trans(@alphabet.rotate($.key) Z=> @alphabet);
    }
}

sub encrypt(Int $key, Str $text) is export  {
    my $message = Message.new(
        key => $key,
        text => $text
    );
    $message.encrypt
}

sub encrypt-from-file(Int $key, Str $orig, Str $dest) is export {
    die "Can't locate $orig" unless $orig.IO ~~ :e;
    if $orig eq $dest {
      warn 'Your origin file will be erased !';
    }
    my Str $message = slurp($orig);
    my Str $encrypted = encrypt($key, $message);
    my $fh = open($dest, :w);
    $fh.say($encrypted);
    $fh.close;
}

sub decrypt(Int $key, Str $text) is export {
    my $secret = Secret.new(
        key => $key,
        text => $text
    );
    $secret.decrypt
}

sub decrypt-from-file(Int $key where 1..25, Str $orig, Str $dest) is export {
    die "Can't locate $orig !" unless $orig.IO ~~ :e;
    if $orig eq $dest {
      warn 'Your origin file will be erased !';
    }
    my Str $message = slurp($orig);
    my Str $decrypted = decrypt($key, $message);

    my $fh = open($dest, :w);
    $fh.say($decrypted);
    $fh.close;
}

=begin pod

=head1 NAME

Text::Caesar - Encrypt / Decrypt using a Caesar cipher

=head1 SYNOPSIS

=begin code :lang<raku>

use Text::Caesar;

my $message = Message.new(
  key  => 3,
  text => "I am a secret message"
);
my $secret = Secret.new(
  key  => 3,
  text => $message.encrypt();
);
say $message.encrypt;
say $secret.decrypt;

=end code

=head1 DESCRIPTION

This module allows you to use 4 functions.

You can encrypt a message:

=begin code :lang<raku>

use Text::Caesar;

my Str $secret = "I'm a secret message.";
my Str $message = encrypt(3, $secret);
say $message;

=end code

You can decrypt a message :

=begin code :lang<raku>

my Str $secret = 'LPDVHFUHWPHVVDJH'
my Str $message = decrypt(3, $secret);
say $message;

=end code

You can encrypt (or decrypt) a file:

=begin code :lang<raku>

encrypt-from-file($key, $origin, $destination)

=end code

This code will encrypt C<$origin>'s text into the C<$destination> file.

You can also use objects:

=begin code :lang<raku>

my $message = Message.new(
  key  => 3,
  text => "I am a secret message"
);
say $message.encrypt;

=end code

=begin code :lang<raku>

my $secret = Secret.new(
  key  => 3,
  text => $message.encrypt;
);
say $secret.decrypt;

=end code

=head1 AUTHOR

Emeric Fischer

=head1 COPYRIGHT AND LICENSE

Copyright 2016 - 2017 Emeric Fischer

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
