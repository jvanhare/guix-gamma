(define-module (gamma-nlohmann-json)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy))

(define-public gamma-nlohmann-json
  (package
    (name "gamma-nlohmann-json")
    (version "3.11.3")
    (source
      (origin
        (method url-fetch)
        (uri "hhttps://github.com/nlohmann/json/releases/download/v3.11.3/json.hpp")
        (sha256 (base32 "19iy237x05xl41fsz1v0viznz4pq09is7r9bdch1qjpgcs04rslv"))))
    (build-system copy-build-system)
    (arguments '(#:install-plan '(("json.hpp" "include/nlohmann/json.hpp"))))
    (home-page "https://cliutils.github.io/CLI11/book")
    (synopsis "JSON parser and printer library for C++")
    (description "@code{nlohmann::json} is a C++ JSON library that provides intuitive syntax and trivial integration.")
    (license license:expat)))
