(define-module (gamma-cli-11)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system copy))

(define-public gamma-cli-11
  (package
    (name "gamma-cli-11")
    (version "2.5.0")
    (source
      (origin
        (method url-fetch)
        (uri "https://github.com/CLIUtils/CLI11/releases/download/v2.5.0/CLI11.hpp")
        (sha256 (base32 "19k3k8cfv3fikhya7k07496mjgj1jm7m8w6sriv92857194skw2b"))))
    (build-system copy-build-system)
    (arguments '(#:install-plan '(("CLI11.hpp" "include/CLI/CLI.hpp"))))
    (home-page "https://cliutils.github.io/CLI11/book")
    (synopsis "Command line parser for C++11")
    (description "CLI11 is a command line parser for C++11 and beyond that provides a rich feature set with a simple and intuitive interface.")
    (license license:bsd-3)))
