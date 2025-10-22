(define-module (gamma-inja)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system copy)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gamma-nlohmann-json)
  #:use-module (gnu packages cpp))

(define-public gamma-inja
  (package
    (name "gamma-inja")
    (version "3.5.0")
    (source
      (origin
        (method url-fetch)
        (uri "https://github.com/pantor/inja/releases/download/v3.5.0/inja.hpp")
        (sha256 (base32 "0jrngz72dfqlm079sx4y0khiirpscyq1v3lyjrbg57lswia3lgaz"))))
    (inputs
     (list gamma-nlohmann-json))
    (build-system copy-build-system)
    (arguments '(#:install-plan '(("inja.hpp" "include/inja/inja.hpp"))))
    (home-page "https://github.com/pantor/inja")
    (synopsis "A Template Engine for Modern C++")
    (description "Inja is a template engine for modern C++, loosely inspired by jinja for python. It has an easy and yet powerful template syntax with all variables, loops, conditions, includes, callbacks, and comments you need, nested and combined as you like.")
    (license license:expat)))
