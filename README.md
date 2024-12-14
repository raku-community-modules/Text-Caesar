[![Actions Status](https://github.com/raku-community-modules/Text-Caesar/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/Text-Caesar/actions) [![Actions Status](https://github.com/raku-community-modules/Text-Caesar/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/Text-Caesar/actions) [![Actions Status](https://github.com/raku-community-modules/Text-Caesar/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/Text-Caesar/actions)

NAME
====

Text::Caesar - Encrypt / Decrypt using a Caesar cipher

SYNOPSIS
========

```raku
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
```

DESCRIPTION
===========

This module allows you to use 4 functions.

You can encrypt a message:

```raku
use Text::Caesar;

my Str $secret = "I'm a secret message.";
my Str $message = encrypt(3, $secret);
say $message;
```

You can decrypt a message :

```raku
my Str $secret = 'LPDVHFUHWPHVVDJH'
my Str $message = decrypt(3, $secret);
say $message;
```

You can encrypt (or decrypt) a file:

```raku
encrypt-from-file($key, $origin, $destination)
```

This code will encrypt `$origin`'s text into the `$destination` file.

You can also use objects:

```raku
my $message = Message.new(
  key  => 3,
  text => "I am a secret message"
);
say $message.encrypt;
```

```raku
my $secret = Secret.new(
  key  => 3,
  text => $message.encrypt;
);
say $secret.decrypt;
```

AUTHOR
======

Emeric Fischer

COPYRIGHT AND LICENSE
=====================

Copyright 2016 - 2017 Emeric Fischer

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

