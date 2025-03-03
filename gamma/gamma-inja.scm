(define-module (gamma-inja)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system copy)
  #:use-module (guix git-download)
  #:use-module (gnu packages cpp))

(define-public gamma-inja
  (package
    (name "gamma-inja")
    (version "3.4.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/pantor/inja")
              (commit "b227644")))
        (file-name (git-file-name name version))
        (sha256 (base32 "15aiycrhacz8wwz2fpbr4yaxs3sxdxb9xpbskg5nkpwdx93ill87"))))
    (inputs
     (list gamma-nlohmann-json))
    (build-system copy-build-system)
    (arguments '(#:install-plan '(("single_include/inja/inja.hpp" "include/inja/inja.hpp"))))
    (home-page "https://github.com/pantor/inja")
    (synopsis "A Template Engine for Modern C++")
    (description "Inja is a template engine for modern C++, loosely inspired by jinja for python. It has an easy and yet powerful template syntax with all variables, loops, conditions, includes, callbacks, and comments you need, nested and combined as you like.")
    (license license:expat)))
