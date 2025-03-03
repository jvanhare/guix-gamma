# guix-gamma: Guix channel for Inria Gamma softwares

To add this channel to your Guix configuration, add the following lines to a `channels.scm` file:

```scheme
(cons (channel
        (name 'gamma)
        (url "https://github.com/jvanhare/guix-gamma.git"))
      %default-channels)
```

Then, run `guix pull -C channels.scm` to update your Guix configuration.
